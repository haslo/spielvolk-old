class AddEventGamesLinks < ActiveRecord::Migration
  def self.up
    create_table :events_games, :id => false do |t|
      t.references :events, :games
    end
    create_table :event_instances_games, :id => false do |t|
      t.references :event_instances, :games
    end
  end

  def self.down
    drop_table :events_games
    drop_table :event_instances_games
  end
end
