class Stock < ActiveRecord::Base
  attr_accessible :latest_price, :symbol
  belongs_to :company
  belongs_to :exchange

  has_many :trades
  has_many :bids

  monetize :latest_price_cents, :allow_nil => false, :numericality => {
      :greater_than_or_equal_to => 0
  }


end
