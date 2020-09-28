class CreateFunds < ActiveRecord::Migration[6.0]
  def change
    create_table :funds do |t|
      t.belongs_to :portfolio, null: false, foreign_key: true
      t.string :category, null: false
      t.float :amount, null: false
      t.date :date, null: false

      t.timestamps
    end
  end
end
