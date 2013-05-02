class League < ActiveRecord::Base
  has_many :user_league_associations
  has_many :users , :through => :user_league_associations
  has_and_belongs_to_many :exchanges
  attr_accessible :algo_name, :category, :description, :market, :title, :users, :start_time, :end_time, :latest_registration_time, :commission, :invitation_only, :buy_in, :max_users, :min_users

  monetize :virtual_money_cents, :allow_nil => false, :numericality => {
      :greater_than_or_equal_to => 0
  }

  before_save :default_values


  def update_positions!
    user_league_associations.each do |ula|
      ula.investment = ula.calculate_investment
    end
    user_league_associations.sort_by {|u| (u.investment + u.balance) * -1}.each_with_index do |ula, ii|
      ula.rank = ii+1
      ula.save!
    end
  end

  def default_values
    self.virtual_money ||= Money.new(100000000) unless self.virtual_money_cents

  end

  def started?
    start_time >= Time.now
  end

  def in_progress?
    start_time >= Time.now && end_time < Time.now
  end

  def prize_pool
    Money.new(buy_in * 100 * user_league_associations.count)
  end

  def entrants
    user_league_associations.count
  end

  def places_paid
    10
  end

  def average_return
    5.43
  end

end
