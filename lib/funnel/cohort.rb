class Cohort
  attr_accessor :month, :year

  def initialize(month, year)
    @month = month
    @year = year
  end

  def init_stages(stage_classes)
    @stages = []

    stage_classes.each do |stage_class|
      previous_stage = @stages.last
      @stages << stage_class.new(self, previous_stage)
    end
  end

  def load
    @stages.each { |s| s.load }
  end

  def process
    @stages.each { |s| s.process }
  end

  def results_to_a
    @stages.map { |s| s.count }
  end

  def to_s
    "#{@year}-#{@month}"
  end
end
