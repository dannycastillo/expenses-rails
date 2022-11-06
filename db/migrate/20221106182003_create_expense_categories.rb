class CreateExpenseCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :expense_categories do |t|
      t.string :name
      t.string :slug
      t.references :category_group, null: false, foreign_key: true

      t.timestamps
    end
  end
end