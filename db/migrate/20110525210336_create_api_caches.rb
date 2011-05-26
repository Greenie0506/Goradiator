class CreateApiCaches < ActiveRecord::Migration
  def self.up
    create_table :api_caches do |t|
      t.string :service_type
      t.string :data

      t.timestamps
    end
  end

  def self.down
    drop_table :api_caches
  end
end
