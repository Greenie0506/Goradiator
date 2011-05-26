class AddValidForToApiCache < ActiveRecord::Migration
  def self.up
    add_column :api_caches, :valid_for, :time, :empty => false
  end

  def self.down
    remove_column :api_caches, :valid_for
  end
end
