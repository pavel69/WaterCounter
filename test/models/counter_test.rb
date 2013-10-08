require 'test_helper'

class CounterTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "find" do
    @counter = Counter.find(2);

    puts @counter.date
    @zz = Counter.all :conditions => {['date <= ?', @counter.date]}
  end
end
