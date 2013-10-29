class AddConsuptionsToCounters < ActiveRecord::Migration
  def change
    add_column :counters, :prev_id, :integer
    add_column :counters, :warm_consumption, :integer
    add_column :counters, :cold_consumption, :integer
    add_column :counters, :prev_warm_consumption, :integer
		add_column :counters, :prev_cold_consumption, :integer

		add_index :counters, :date, unique: true
  end
end
