class Users::Account < ActiveRecord::Base

  self.table_name = :user_accounts

  belongs_to :user

  has_one :payment_method, :class_name => 'Users::PaymentMethod'
  has_many :transactions, :class_name => 'Users::Transaction'

  monetize :balance_cents, :allow_nil => false, :numericality => {
      :greater_than_or_equal_to => 0
  }, :with_currency => :usd

  validates_presence_of :user_id


  def create_payment_method_and_make_payment!(params_hash, money, transaction = "Deposit")
     # hard coding to paypal for now
    payment_method = Users::PaypalPaymentMethod.create!(:account => self,:type => Users::PaymentMethod.type_paypal,
                                                  :identifier => nil, :info => "")
     # payment_method.make_deposit!(money) if transaction == "Deposit"
     # payment_method.make_withdrawl!(money) if transaction == "Withdrawl"

  end



end
