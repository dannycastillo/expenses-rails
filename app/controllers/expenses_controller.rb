class ExpensesController < ApplicationController
  def index
    all_expenses = Expense.all
    expenses_by_month = all_expenses.group_by { |i| i.date.strftime("%Y-%m") }

    months = expenses_by_month.keys.sort

    @expenses = months.map do |month|
      {
        month: format_month(month),
        category_totals: calculate_category_totals(expenses_by_month[month])
      }
    end
  end

  private

  def calculate_category_totals(expenses)
    expenses_by_category_id = expenses.group_by { |i| i.expense_category_id }
    category_ids = expenses_by_category_id.keys.sort
    categories_by_id = ExpenseCategory.where(id: category_ids).group_by { |i| i.id }

    category_ids.map do |category_id|
      amounts = expenses_by_category_id[category_id].map { |i| i.amount }
      {
        name: categories_by_id[category_id][0].name,
        total: "#{amounts.reduce(:+).to_f}"
      } 
    end
  end

  def format_month(month_string)
    Date.strptime(month_string, "%Y-%m").strftime("%B %Y")
  end

end
