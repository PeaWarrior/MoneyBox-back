class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.belongs_to :portfolio, null: false, foreign_key: true
      t.string :name
      t.string :ticker

      t.timestamps
    end
  end
end
