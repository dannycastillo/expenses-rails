class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.references :account, null: false, foreign_key: true
      t.decimal :amount, null: false
      t.datetime :date, null: false
      t.string :description
      t.references :expense_category, null: false, foreign_key: true
      t.references :vendor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
