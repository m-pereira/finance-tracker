class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.string :ticker, null: false
      t.string :name, null: false
      t.decimal :last_price

      t.timestamps
    end
  end
end
