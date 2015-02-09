class ChangeCurrenciesToStrongModel < ActiveRecord::Migration
  def self.up
    change_table :currencies do |t|
      t.change :name, :string, null: false
      t.change :converter, :integer, null: false
      t.change :code, :string, null: false
      t.change :buy_price, :float, null: false
      t.change :sell_price, :float, null: false
      t.change :exchange_id, :integer, null: false
    end
  end

  def self.down
    change_table :currencies do |t|
      t.change :name, :string, null: true
      t.change :converter, :integer, null: true
      t.change :code, :string, null: true
      t.change :buy_price, :float, null: true
      t.change :sell_price, :float, null: true
      t.change :exchange_id, :integer, null: true
    end
  end
end
