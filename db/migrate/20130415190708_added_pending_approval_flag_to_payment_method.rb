class AddedPendingApprovalFlagToPaymentMethod < ActiveRecord::Migration
  add_column :user_payment_methods, :pending_approval, :boolean, :default => false
end
