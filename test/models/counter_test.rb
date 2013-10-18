require 'test_helper'

class CounterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Create new Counter test" do
    c = Counter.new;

    assert c.invalid?
    
    
    assert c.valid?
  end
end
