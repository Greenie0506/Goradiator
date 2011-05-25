class AddDatabaseConstraintsToApiCache < ActiveRecord::Migration
  def self.up
    change_column :api_caches, :service_type, :string, :empty => false
    change_column :api_caches, :data, :string, :empty => false
  end

  def self.down
    change_column :api_caches, :service_type, :string, :empty => true
    change_column :api_caches, :data, :string, :empty => true
  end
end
