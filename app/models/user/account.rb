class User::Account < ActiveRecord::Base

  belongs_to :user

  has_many :transactions, :class_name => 'User::Transaction'

  monetize :balance, :allow_nil => false

  validates_presence_of :user_id


  def create_payment_method_make_payment(params_hash, money, transaction = "deposit")

  end



end
