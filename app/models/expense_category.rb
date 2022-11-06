class ExpenseCategory < ApplicationRecord
  belongs_to :expense_category_group, optional: true

  def normalize_slug
    self.slug = self.slug.parameterize
  end
end
