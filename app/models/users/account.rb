class Users::Account < ActiveRecord::Base

  self.table_name = :user_accounts

  belongs_to :user

  has_many :payment_methods, :class_name => 'Users::PaymentMethod'

  monetize :balance_cents, :allow_nil => false, :numericality => {
      :greater_than_or_equal_to => 0
  }, :with_currency => :usd

  validates_presence_of :user_id


  def create_payment_method_and_make_payment!(params_hash, money, transaction = "Deposit")
     # hard coding to braintree for now
    cc_hash = params_hash[:credit_card]
    date_hash = params_hash[:date]
    result = Braintree::Customer.create(
        :first_name => cc_hash[:name],
        :last_name => " ",
        :credit_card => {
            :cardholder_name => cc_hash[:name],
            :number => cc_hash[:number],
            :cvv => cc_hash[:cvv],
            :expiration_date => "#{date_hash[:expiry_month]}/#{date_hash[:expiry_year]}",
            :options => {
                :verify_card => true
            }
        }
    )
    if result.success?
      info_string = "#{cc_hash[:name]}'s credit card ending with #{cc_hash[:number].slice(-4..-1)}"
      payment_method = Users::BraintreePaymentMethod.create!(:account => self,:type => Users::PaymentMethod.type_credit_card,
                                                  :identifier => result.customer.id, :info => info_string)
      payment_method.make_deposit!(money) if transaction == "Deposit"
      payment_method.make_withdrawl!(money) if transaction == "Withdrawl"
    else
      raise PaymentGatewayException.new(result.message)
    end


  end



end
