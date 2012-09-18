class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :quantity
      t.references :customer
      t.references :item

      t.timestamps
    end
    add_index :transactions, :customer_id
    add_index :transactions, :item_id
  end
end
