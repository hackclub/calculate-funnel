require_relative '../work_pool.rb'
require_relative './stages/submits_application'
require_relative './stages/non_spam_application'

class Funnel
  STAGES = [
    SubmitsApplication,
    NonSpamApplication,
  ]

  def initialize(*cohorts)
    @cohorts = cohorts

    @cohorts.each { |c| c.init_stages(STAGES) }
  end

  def load
    @cohorts.each do |cohort|
      puts "Loading #{cohort.to_s}..."
      cohort.load
    end
  end

  def process
    @cohorts.each do |cohort|
      puts "Processing #{cohort.to_s}..."
      cohort.process
    end
  end

  def render
    arr = []

    arr << [
      nil,
      *STAGES
    ]

    @cohorts.each do |cohort|
      header = [cohort.to_s]
      arr << header + cohort.results_to_a
    end

    arr.transpose.map { |row| row.join("\t") }.join("\n")
  end
end
