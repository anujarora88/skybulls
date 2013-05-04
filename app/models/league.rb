class League < ActiveRecord::Base

  include Notify

  has_many :user_league_associations
  has_many :users , :through => :user_league_associations
  has_and_belongs_to_many :exchanges
  attr_accessible :algo_name, :category, :description, :market, :title, :users, :start_time, :end_time, :latest_registration_time, :commission, :invitation_only, :buy_in, :max_users, :min_users

  monetize :virtual_money_cents, :allow_nil => false, :numericality => {
      :greater_than_or_equal_to => 0
  }

  before_save :default_values

  validates_presence_of :start_time, :end_time, :category, :title, :buy_in, :commission




  def update_positions!
    user_league_associations.each do |ula|
      ula.investment = ula.calculate_investment
    end
    user_league_associations.sort_by {|u| (u.investment + u.balance) * -1}.each_with_index do |ula, ii|
      ula.rank = ii+1
      ula.save!
    end
  end

  def total_pot
    user_league_associations.size
  end

  def pay_winners!
    update_positions!
    payout_str = payout_structure
    payout_str.each_with_index do |val, ii|
       payout = prize_pool * val/100
       user_league_association = user_league_associations.where(rank: ii+1).first
       if payout > 0
          Users::Deposit.create!(:identifier => "system", :amount => payout, :user_league_association => user_league_association, :account => user_league_association.user.account)
       end

    end
  end

  def total_buy_in_cost
    Money.new((buy_in + commission*buy_in/100)*100)
  end

  def execute_open_trades!
    user_league_associations.each do |ula|
      open_trades = ula.open_trades
      open_trades.each do |o|
         trade = Trades::Sell.new(:price => o[:stock].latest_price, :amount => o[:amount], :stock => o[:stock],
                             :user_league_association => ula)
        trade.system_created= true
        trade.save!
      end
    end
  end

  def name_with_date
    time_string = start_time.strftime("#{start_time.day.ordinalize} %b %Y")
    "#{title} - #{time_string}"
  end

  def default_values
    self.virtual_money ||= Money.new(100000000) unless self.virtual_money_cents

  end

  def started?
    start_time <= Time.now
  end

  def in_progress?
    trade_allowed?
  end

  def prize_pool
    Money.new(buy_in * 100 * user_league_associations.count)
  end

  def entrants
    user_league_associations.count
  end

  def places_paid
    payout_structure.size
  end

  def average_return
     5.41
  end

  def leaders
    user_league_associations.order(:rank).limit(10).all
  end

  def payout_structure
    size = user_league_associations.count
    if size <=2
      [100]
    elsif size <=4
      [60, 40]
    elsif size <=12
      [50,30,20]
    elsif size <=18
      [40, 30, 20, 10]
    elsif size <=27
      [40, 23, 16, 12, 9]
    elsif size <=36
      [33,20,15, 11, 8, 7, 6]
    else
      [20, 20, 20, 20 , 20]
    end

  end

  def trade_allowed?(time = Time.now)
    !completed? && start_time <= time && end_time > time
  end

end
