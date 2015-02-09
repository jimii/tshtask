class ChangeExchangeNameColumnNotNull < ActiveRecord::Migration
  def self.up
    change_column :exchanges, :name, :string, null: false, unique: true
    add_index "exchanges", ["name"], name: "index_exchanges_on_name", unique: true, using: :btree
  end

  def self.down
    change_column :exchanges, :name, :string, null: true, unique: false
    remove_index "exchanges", ["name"]
  end
end
