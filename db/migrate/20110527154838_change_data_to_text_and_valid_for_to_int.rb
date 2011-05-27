class ChangeDataToTextAndValidForToInt < ActiveRecord::Migration
  def self.up
    change_column :api_caches, :data, :text
    change_column :api_caches, :valid_for, :integer
  end

  def self.down
    change_column :api_caches, :data, :string
    change_column :api_caches, :valid_for, :time
  end
end
