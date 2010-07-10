class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.string :description
      t.float :total
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end
