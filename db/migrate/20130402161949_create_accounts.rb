class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :user_accounts do |t|

      t.timestamps
      t.integer :user_id, null: false
      t.foreign_key :users
      t.money :balance, currency: { present: false }


    end

  end
end
