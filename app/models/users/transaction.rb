class Users::Transaction < ActiveRecord::Base

  self.table_name = :user_transactions

  belongs_to :payment_method, :class_name => 'Users::PaymentMethod'
  belongs_to :user_league_association
  belongs_to :account, :class_name => 'Users::Account'

  monetize :amount_cents, :allow_nil => false, :numericality => {
      :greater_than_or_equal_to => 0
  }, :with_currency => :usd

  validates_presence_of :type, :identifier, :account_id

  after_create :update_balance

  attr_accessible :payment_method, :account, :amount, :amount_cents, :payment_method, :payment_method_id , :identifier, :user_league_association


  private

    def update_balance
      raise "Attempt to call an abstract method"
    end

end
