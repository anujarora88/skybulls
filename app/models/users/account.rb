class Users::Account < ActiveRecord::Base

  set_table_name :user_accounts

  belongs_to :user

  has_many :transactions, :class_name => 'Users::Transaction'

  monetize :balance_cents, :allow_nil => false, :numericality => {
      :greater_than_or_equal_to => 0
  }, :with_currency => :usd

  validates_presence_of :user_id


  def create_payment_method_and_make_payment(params_hash, money, transaction = "deposit")

  end



end
