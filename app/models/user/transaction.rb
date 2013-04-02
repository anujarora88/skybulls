class User::Transaction < ActiveRecord::Base

  belongs_to :account, :class_name => 'User::Account'

  belongs_to :payment_method, :class_name => 'User::PaymentMethod'

  monetize :amount, :allow_nil => false

  validates_presence_of :type, :account_id, :identifier, :payment_method_id

end
