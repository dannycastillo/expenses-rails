class CreateExpenseCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :expense_categories do |t|
      t.string :name, null: false
      t.string :slug, null: false, index: { unique: true }
      t.references :expense_category_group, foreign_key: true

      t.timestamps
    end
  end
end
