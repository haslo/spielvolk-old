class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.integer :place_id
      t.date :start_date
      t.time :start_time
      t.time :end_time
      t.string :repetition_description

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
