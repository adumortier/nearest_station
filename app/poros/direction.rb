class Direction

  attr_reader :distance, :travel_time, :direction_instructions

  def initialize(info) 
    @distance = info[:distance][:text]
    @travel_time = info[:duration][:text]
    @direction_instructions = get_directions(info[:steps])
  end 

  def get_directions(steps)
    result = steps.map do |step|
      step[:html_instructions]
    end.join(' ') 
    return result
  end
  
end