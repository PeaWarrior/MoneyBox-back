class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.belongs_to :stock, null: false, foreign_key: true
      t.string :category
      t.float :price
      t.float :shares, default: nil
      t.float :remaining
      t.date :date

      t.timestamps
    end
  end
end