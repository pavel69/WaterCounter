class CalculateConsumption < ActiveRecord::Migration
  def up
    Counter.all.each do |counter|
      x = counter.find_prev_record

      counter.update_attributes(prev_id: x.id, warm_consumption: (counter.warm - x.warm), cold_consumption: (counter.cold - x.cold)) if !x.nil?
    end

    Counter.all.each do |counter|
      x = counter.prev_counter

      counter.update_attributes(prev_warm_consumption: x.warm_consumption, prev_cold_consumption: x.cold_consumption) if !x.nil?
    end

  end

  def down
    Counter.update_all 'prev_id = null, warm_consumption = null, cold_consumption = null, prev_warm_consumption = null, prev_cold_consumption = null'
  end
end
