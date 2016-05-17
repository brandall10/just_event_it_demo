require './sum_event'

class MyPoro
  include Events::SumEvent
  
  MAX_SUM = 100
  attr_reader :sum  
  
  def self.sum_warning_handler(instance)
    if instance.sum > MAX_SUM
      $stderr.puts "Warning: sum is greater than max of #{MAX_SUM}. Let's not get crazy folks!"
    end
  end
  
  on_sum_event { |instance| puts "Your sum is: #{instance.sum}" }
  on_sum_event :sum_warning_handler
  
  def calculate_sum(lower, upper)
    @sum = (lower..upper).to_a.reduce(:+)
    
    # Invoke handlers
    trigger_sum_event
    
    @sum
  end
end
