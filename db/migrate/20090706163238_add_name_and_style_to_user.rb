class AddNameAndStyleToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :style, :string
    add_column :users, :first_name, :string
    add_column :users, :name, :string
  end

  def self.down
    remove_column :users, :style
    remove_column :users, :first_name
    remove_column :users, :name
  end
end
