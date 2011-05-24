class RenameEventNameToTitle < ActiveRecord::Migration
  def self.up
    rename_column :events, 'name', 'title'
  end

  def self.down
    rename_column :events, 'title', 'name'
  end
end
