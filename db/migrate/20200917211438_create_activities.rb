class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.belongs_to :portfolio, null: false, foreign_key: true
      t.string :category
      t.integer :price
      t.integer :shares, default: nil
      t.date :date

      t.timestamps
    end
  end
end
