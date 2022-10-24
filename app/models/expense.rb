class Expense < ApplicationRecord
  belongs_to :account
  belongs_to :expense_category
  belongs_to :vendor
end
