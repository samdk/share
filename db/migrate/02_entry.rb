class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.string :description
      t.number :total

      t.timestamps
    end
  end

  def self.down
    drop_table :entries
  end
end
