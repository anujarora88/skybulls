class Users::PaymentMethod < ActiveRecord::Base

  self.table_name = :user_payment_methods

  set_inheritance_column :payment_gateway

  belongs_to :account, :class_name => 'Users::Account'

  has_many :transactions, :class_name => 'Users::Transaction'

  validates_presence_of :type, :payment_gateway, :identifier, :account_id, :info

  @@type_credit_card = "credit_card"

  @@supported_types = [@@type_credit_card].freeze

  cattr_reader :type_credit_card

  validates_inclusion_of :type, :in => @@supported_types

  attr_accessible :type, :identifier, :account, :info, :account_id

  def make_deposit!(money)
     process_deposit!(money)
  end

  def make_withdrawl!(money)
    #TODO improve this later
    raise "Not enough Balance!!" if account.balance < money
    process_withdrawl!(money)
  end

  private

    def process_deposit!(money)
      raise "Attempt to call an abstract method"
    end

    def process_withdrawl!(money)
      raise "Attempt to call an abstract method"
    end


end
