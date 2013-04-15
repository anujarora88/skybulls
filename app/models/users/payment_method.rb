class Users::PaymentMethod < ActiveRecord::Base

  self.table_name = :user_payment_methods

  set_inheritance_column :payment_gateway

  belongs_to :account, :class_name => 'Users::Account'

  has_many :transactions, :class_name => 'Users::Transaction'

  validates_presence_of :type, :payment_gateway, :account_id

  @@type_credit_card = "credit_card"
  @@type_paypal = "paypal"

  @@supported_types = [@@type_credit_card, @@type_paypal].freeze

  cattr_reader :type_credit_card, :type_paypal

  validates_inclusion_of :type, :in => @@supported_types

  attr_accessible :type, :identifier, :account, :info, :account_id, :pending_approval

  def make_deposit!(money, params_hash)
     raise PaymentException("Cannot process a deposit using this account!") unless deposit_allowed?
     process_deposit!(money, params_hash)
  end

  def make_withdrawl!(money, params_hash)
    raise PaymentException("Not enough Balance!") if account.balance < money
    process_withdrawl!(money, params_hash)
  end

  def deposit_allowed?
    true
  end



  private

    def process_deposit!(money, params_hash)
      raise "Attempt to call an abstract method"
    end

    def process_withdrawl!(money, params_hash)
      raise "Attempt to call an abstract method"
    end


end
