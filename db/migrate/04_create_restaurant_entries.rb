class CreateRestaurantEntries < ActiveRecord::Migration
  def self.up
    create_table :restaurant_entries do |t|
      t.string :description
      t.float :tip
      t.float :tax

      t.timestamps
    end
  end

  def self.down
    drop_table :restaurant_entries
  end
end
