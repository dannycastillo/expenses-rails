require 'csv'
namespace :import_expenses do
  desc "Upsert Expenses from CSV based on date/amount/vendor uniqueness"

  task :csv, [:filepath] => [:environment] do |task, args|
    filepath = args[:filepath]

    existing_accounts = Account.all
    existing_expense_categories = ExpenseCategory.all
    existing_vendors = Vendor.all

    new_expenses = 0
    existing_expenses = 0

    CSV.foreach(filepath, :headers => true, :force_quotes => true) do |row|
      date = DateTime.strptime(row["Date"], '%m/%d/%Y')
      amount = BigDecimal(row["Amount"])

      # find or create account
      account_name = row["Account"]
      account_slug = row["Account"].parameterize
      account = existing_accounts.find { |element| element.slug == account_slug } 
      if account.blank?
        account = Account.create!(name: account_name, slug: account_slug)
        existing_accounts.reload
      end
      
      # find or create expense_category
      expense_category_name = row["Category"]
      expense_category_slug = row["Category"].parameterize
      expense_category = existing_expense_categories.find { |element| element.slug == expense_category_slug } 
      if expense_category.blank?
        expense_category = ExpenseCategory.create!(name: expense_category_name, slug: expense_category_slug)
        existing_expense_categories.reload
      end

      # find or create vendor
      vendor_name = row["Vendor"]
      vendor_slug = row["Vendor"].parameterize
      vendor = existing_vendors.find { |element| element.slug == vendor_slug } 
      if vendor.blank?
        vendor = Vendor.create!(name: vendor_name, slug: vendor_slug)
        existing_vendors.reload
      end

      expense = {
        date: date,
        amount: amount,
        vendor_id: vendor.id,
        expense_category_id: expense_category.id,
        account_id: account.id
      }

      unless Expense.find_by(date: expense[:date], amount: expense[:amount], vendor_id: expense[:vendor_id])
        Expense.create!(expense)
        new_expenses +=1
      else
        existing_expenses +=1
      end
    end
    puts "#{new_expenses} New Expenses, #{existing_expenses} Existing Expenses"
  end
end
