class UserLeagueAssociation < ActiveRecord::Base
  attr_accessible :league_id, :user_id

  belongs_to :user
  belongs_to :league

  has_many :trades
  has_many :bids

  monetize :balance_cents, :allow_nil => false, :numericality => {
      :greater_than_or_equal_to => 0
  }

  after_create :debit_user_account!


  def stock_amount(stock)
    count = 0
    trades.where({stock_id: stock.id}).all.each do |t|
      count = count + t.shares
    end
    count
  end

  private

    def debit_user_account!
      Users::Withdrawl.create!(:amount => league.virtual_money, :user_league_association => self, :account => user.account)
    end

end
