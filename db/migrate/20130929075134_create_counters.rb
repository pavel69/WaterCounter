class CreateCounters < ActiveRecord::Migration
  def change
    create_table :counters do |t|
      t.date :date
      t.integer :warm
      t.integer :cold

      t.timestamps
    end
  end
end
