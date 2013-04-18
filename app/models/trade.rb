class Trade < ActiveRecord::Base

  self.table_name = :trades

  attr_accessible :amount, :stock_id, :price, :type, :user_league_association_id

  belongs_to :stock
  belongs_to :user_league_association

  monetize :price_cents, :allow_nil => false, :numericality => {
      :greater_than_or_equal_to => 0
  }

  validates_presence_of :stock_id, :type, :user_league_association_id

  has_one :bid


end
