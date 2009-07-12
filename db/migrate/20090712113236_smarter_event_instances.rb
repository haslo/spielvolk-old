class SmarterEventInstances < ActiveRecord::Migration
  def self.up
    add_column :event_instances, :start_time, :time
    add_column :event_instances, :end_time, :time
  end

  def self.down
    remove_column :event_instances, :start_time
    remove_column :event_instances, :end_time
  end
end
