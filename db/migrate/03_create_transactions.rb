class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.references :user
      t.references :entry

      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
