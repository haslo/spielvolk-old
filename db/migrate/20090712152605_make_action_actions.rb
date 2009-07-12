class MakeActionActions < ActiveRecord::Migration
  def self.up
    rename_column :rights, :action, :actions
  end

  def self.down
    rename_column :rights, :actions, :action
  end
end
