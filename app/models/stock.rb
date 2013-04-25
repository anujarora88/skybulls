class Stock < ActiveRecord::Base
  attr_accessible :latest_price, :symbol, :exchange_id, :company_id
  belongs_to :company
  belongs_to :exchange

  has_many :trades
  has_many :bids

  monetize :latest_price_cents, :allow_nil => false, :numericality => {
      :greater_than_or_equal_to => 0
  }

  def symbol_with_exchange
    "#{exchange.symbol}:#{symbol}"
  end

  def to_json
    {
        :id => id,
        :symbol => symbol_with_exchange,
        :name => company.name,
        :logoUrl => company.logo_url,
        :price => latest_price.format,
        :percentageChange => 1,
        :change => 10
    }.to_json
  end


end
