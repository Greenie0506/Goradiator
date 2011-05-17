class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.datetime :time
      t.string :name
      t.string :speaker

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
