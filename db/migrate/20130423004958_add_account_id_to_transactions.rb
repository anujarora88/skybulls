class AddAccountIdToTransactions < ActiveRecord::Migration
  def change
    add_column :user_transactions, :account_id, :integer
    add_column :user_transactions, :user_league_association_id, :integer

    add_foreign_key(:user_transactions, :user_league_associations)
    add_foreign_key(:user_transactions, :user_accounts, column: :account_id)

  end
end
