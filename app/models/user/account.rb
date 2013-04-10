class User::Account < ActiveRecord::Base

  belongs_to :user

  has_many :transactions, :class_name => 'User::Transaction'

  monetize :balance_cents, :allow_nil => false, :numericality => {
      :greater_than_or_equal_to => 0
  }, :with_currency => :usd

  validates_presence_of :user_id


  def create_payment_method_and_make_payment(params_hash, money, transaction = "deposit")

  end



end
