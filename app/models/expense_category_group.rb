class ExpenseCategoryGroup < ApplicationRecord

  def normalize_slug
    self.slug = self.slug.parameterize
  end
end
