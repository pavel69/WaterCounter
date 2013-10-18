class CalculateConsumption < ActiveRecord::Migration
  def up
    Counter.all.each do |counter|
      x = Counter.prev_record(counter.date)
      #x = Counter.where('date < ?',  counter.date).order('date').last

      unless x.nil?
        counter.update_attributes(prev_id: x.id, warm_consumption: (counter.warm - x.warm), cold_consumption: (counter.cold - x.cold))
      end

    end
  end

  def down
    Counter.update_all 'prev_id = null, warm_consumption = null, cold_consumption = null'
  end
end
