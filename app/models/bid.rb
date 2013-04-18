class Bid < ActiveRecord::Base
  attr_accessible :amount, :stock_id, :trade_id, :type, :user_league_association_id, :price

  monetize :price_cents, :allow_nil => false, :numericality => {
      :greater_than_or_equal_to => 0
  }

  belongs_to :stock
  belongs_to :user_league_association

  belongs_to :trade

  monetize :price_cents, :allow_nil => false, :numericality => {
      :greater_than_or_equal_to => 0
  }

  validates_presence_of :stock_id, :type, :user_league_association_id

end
