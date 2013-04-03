class CreateUserTransactions < ActiveRecord::Migration
  def change
    create_table :user_transactions do |t|
      t.integer :payment_method_id, null:false

      t.foreign_key :user_accounts, :column => :account_id
      t.foreign_key :user_payment_methods, :column => :payment_method_id
      t.money :amount, currency: { present: false }
      t.string :type, null: false
      t.string :identifier, null: false
      t.timestamps
    end
  end
end
