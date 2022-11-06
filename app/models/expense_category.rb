class ExpenseCategory < ApplicationRecord

  def normalize_slug
    self.slug = self.slug.parameterize
  end
  belongs_to :expense_category_group
end
