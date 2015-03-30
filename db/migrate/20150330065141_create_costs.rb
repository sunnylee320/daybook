class CreateCosts < ActiveRecord::Migration
  def change
    create_table :costs do |t|
      t.date :buyday
      t.string :item
      t.integer :spendmoney

      t.timestamps null: false
    end
  end
end
