class Stock < ActiveRecord::Base
  attr_accessible :latest_price, :symbol, :exchange_id, :company_id
  belongs_to :company
  belongs_to :exchange

  has_many :trades
  has_many :bids

  has_many :user_stock_associations, :class_name => 'UserStockAssociation'
  has_many :users, :through => :user_stock_associations


  monetize :latest_price_cents, :allow_nil => false, :numericality => {
      :greater_than_or_equal_to => 0
  }

  def symbol_with_exchange
    "#{exchange.symbol}:#{symbol}"
  end

  def pinned?(user)
    user.pinned_stocks.include? self
  end

  def to_s
    "#{company.name} (#{symbol})"
  end

  def to_json
    {
        :id => id,
        :label => to_s,
        :value => id,
        :symbol => symbol_with_exchange,
        :name => company.name,
        :logoUrl => company.logo_url,
        :price => latest_price_cents/100,
        :percentageChange => percentage_change,
        :change => change
    }.to_json
  end


end
