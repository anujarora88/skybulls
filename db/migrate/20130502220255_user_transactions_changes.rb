class UserTransactionsChanges < ActiveRecord::Migration
  def change
    change_column :user_transactions, :payment_method_id, :integer, null: true
    change_column :user_transactions, :account_id, :integer, null: false
  end
end
