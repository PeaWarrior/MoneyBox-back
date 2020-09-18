class CreateActivityStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :activity_stocks do |t|
      t.belongs_to :activity, null: false, foreign_key: true
      t.belongs_to :stock, null: false, foreign_key: true

      t.timestamps
    end
  end
end
