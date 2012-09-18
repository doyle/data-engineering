class AddIndex < ActiveRecord::Migration

  def up
    add_index :customers, :name
    add_index :merchants, :name
    add_index :items, :description
  end

  def down
    remove_index :customers, :name
    remove_index :merchants, :name
    remove_index :items, :description
  end
end
