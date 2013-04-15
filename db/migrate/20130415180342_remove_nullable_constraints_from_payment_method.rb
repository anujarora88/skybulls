class RemoveNullableConstraintsFromPaymentMethod < ActiveRecord::Migration
  def up
    change_column :user_payment_methods, :identifier, :string, :null => true
    change_column :user_payment_methods, :info, :string, :null => true
  end

  def down
    change_column :user_payment_methods, :identifier, :string, :null => false
    change_column :user_payment_methods, :info, :string, :null => false
  end
end
