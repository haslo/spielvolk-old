class MakeEventInstancesExceptionAware < ActiveRecord::Migration
  def self.up
    add_column :event_instances, :is_exception, :boolean, :default => false
    add_column :event_instances, :is_deleted, :boolean, :default => false
  end

  def self.down
    remove_column :event_instances, :is_exception
    remove_column :event_instances, :is_deleted
  end
end
