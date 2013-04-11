class Users::PaymentMethod < ActiveRecord::Base

  set_table_name :user_payment_methods

  set_inheritance_column :payment_gateway

  belongs_to :account, :class_name => 'Users::Account'

  validates_presence_of :type, :payment_gateway, :identifier, :account_id, :info

  TYPE_CREDIT_CARD = "credit_card"

  SUPPORTED_TYPES = [TYPE_CREDIT_CARD]

  validates_inclusion_of :type, :in => SUPPORTED_TYPES

  def make_deposit(money)
     process_deposit(money)
  end

  def make_withdrawl(money)
    #TODO improve this later
    raise "Not enough Balance!!" if account.balance < money
    process_withdrawl(money)
  end

  private

    def process_deposit(money)
      raise "Attempt to call an abstract method"
    end

    def process_withdrawl(money)
      raise "Attempt to call an abstract method"
    end


end
