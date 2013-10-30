class CalculateConsumption < ActiveRecord::Migration
  def up
    Counter.all.order(:date).each do |counter|

      counter.save(validate: false) if counter.recalc
    end
  end

  def down
    Counter.where('id > 1').update_all('prev_id = null, warm_consumption = null, cold_consumption = null, prev_warm_consumption = null, prev_cold_consumption = null')
  end
end
