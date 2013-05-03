class UserLeagueAssociation < ActiveRecord::Base
  attr_accessible :league_id, :user_id

  include Notify

  belongs_to :user
  belongs_to :league

  has_many :trades
  has_many :bids

  monetize :balance_cents, :allow_nil => false, :numericality => {
      :greater_than_or_equal_to => 0
  }

  monetize :investment_cents, :allow_nil => false, :numericality => {
      :greater_than_or_equal_to => 0
  }

  has_many :transactions, :class_name => 'Users::Transaction'

  after_create :debit_user_account!

  before_create :default_values

  def default_values
    self.balance ||= league.virtual_money
    self.investment ||= Money.new(0)
  end

  def total
    balance + investment
  end

  def trades_map
    @trades_map ||= trades.select([:stock_id, :type, "SUM(amount) as amount", "SUM(amount*price_cents) as price_cents"]).group(:stock_id, :type).all
  end

  def open_trades
    return @open_trades if @open_trades
    open_trades = []
    trades_map.group_by(&:stock_id).each do |stock_id, val|
      stock = Stock.find(stock_id)
      amount = 0
      total_cents = 0
      val.each do |v|
         amount += v.shares
        total_cents += v.total_cents_spent
      end
      if amount > 0
        open_trades << {stock: stock, type: Trades::Buy.name, amount: amount,
                              price: Money.new(total_cents/amount, stock.latest_price_currency) }
      end
    end
    @open_trades = open_trades
  end

  def calculate_investment
    open_trades.empty? ? Money.new(0) : open_trades.sum do |ot|
       ot[:stock].latest_price * ot[:amount]
    end
  end

  def stock_amount(stock)
    count = 0
    trades.where({stock_id: stock.id}).all.each do |t|
      count = count + t.shares
    end
    count
  end

  def stock_average_price(stock)
    val = trades_map.group_by(&:stock_id)[stock.id]
    amount = 0
    total_cents = 0
    if val
      val.each do |v|
        amount += v.shares
        total_cents += v.total_cents_spent
      end
    end
    amount == 0 ? Money.new(0) : Money.new(total_cents/amount, stock.latest_price_currency)
  end

  def portfolio_return
    ((total)/league.virtual_money - 1) * 100
  end

  def portfolio_dollar
     total - league.virtual_money
  end

  def real_money_investment
    sum = transactions.where(:type => Users::Withdrawl.name).sum{|t| t.amount}
    sum.is_a?(Money) ? sum : Money.new(sum)
  end

  def real_money_return
    sum = transactions.where(:type => Users::Deposit.name).sum{|t| t.amount}
    sum.is_a?(Money) ? sum : Money.new(sum)
  end

  private

    def debit_user_account!
      Users::Withdrawl.create!(:amount => league.total_buy_in_cost, :user_league_association => self, :account => user.account, :identifier => "system") if amount_cents > 0
    end

end
