require 'minitest/autorun'
require './my_poro'

class MyEventTest < Minitest::Test
  def setup
    @my_poro = MyPoro.new
  end
  
  def test_handlers_are_assigned
    handlers = MyPoro.on_sum_event
    
    assert_equal 2, handlers.count
    assert_kind_of Proc, handlers.first
    assert_kind_of Method, handlers.last
  end
  
  def test_output_handler_is_invoked_on_my_event
    assert_output(/Your sum is: 55/) { @my_poro.calculate_sum(1, 10) }
  end
  
  def test_warning_handler_is_invoked_on_my_event
    std_out = /Your sum is: 285/
    std_err = /Warning: sum is greater than max of 100. Let's not get crazy folks!/
    
    assert_output(std_out, std_err) { @my_poro.calculate_sum(45, 50) }
  end
end
