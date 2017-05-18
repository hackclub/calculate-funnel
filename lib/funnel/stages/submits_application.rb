require_relative './stage.rb'
require_relative '../../website'

class SubmitsApplication < Stage
  attr_accessor :applications

  def load
    @applications = Website.applications_in_month(@cohort.month, @cohort.year)
  end

  def process
  end

  def count
    @applications.count
  end
end
