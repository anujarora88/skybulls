class Users::Transaction < ActiveRecord::Base

  set_table_name :user_transactions

  belongs_to :payment_method, :class_name => 'Users::PaymentMethod'

  monetize :amount_cents, :allow_nil => false, :numericality => {
      :greater_than_or_equal_to => 0
  }, :with_currency => :usd

  validates_presence_of :type, :identifier, :payment_method_id

  after_create :update_balance

  def account
    payment_method.account
  end

  private

    def update_balance
      raise "Attempt to call an abstract method"
    end

end
