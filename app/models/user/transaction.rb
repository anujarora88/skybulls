class User::Transaction < ActiveRecord::Base

  belongs_to :payment_method, :class_name => 'User::PaymentMethod'

  monetize :amount, :allow_nil => false

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
