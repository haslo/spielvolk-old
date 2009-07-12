class CreatePlaces < ActiveRecord::Migration
  def self.up
    create_table :places do |t|
      t.column :title, :string
      t.column :description, :text

      t.timestamps
    end

    add_column :event_instances, :place_id, :integer
  end

  def self.down
    drop_table :places

    remove_column :event_instances, :place_id
  end
end
