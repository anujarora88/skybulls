class User::Account < ActiveRecord::Base

  belongs_to :user

  has_many :transactions, :class_name => 'User::Transaction'

  monetize :balance, :allow_nil => false

  validates_presence_of :user_id

end
