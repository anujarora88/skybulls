class CreateUserPaymentMethods < ActiveRecord::Migration
  def change
    create_table :user_payment_methods do |t|

      t.timestamps
      t.string :type, null: false
      t.string :payment_gateway , null: false
      t.string :identifier, null: false
      t.string :info , null: false
      t.integer :account_id, null: false
      t.foreign_key :user_accounts, column: :account_id


    end
  end
end
