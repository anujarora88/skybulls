class League < ActiveRecord::Base
  has_many :user_league_associations
  has_many :users , :through => :user_league_associations
  has_and_belongs_to_many :exchanges
  attr_accessible :algo_name, :category, :description, :market, :title, :users, :start_time, :end_time, :latest_registration_time, :commission, :invitation_only, :buy_in, :max_users, :min_users

  monetize :virtual_money_cents, :allow_nil => false, :numericality => {
      :greater_than_or_equal_to => 0
  }

  before_save :default_values

  def default_values
    self.virtual_money ||= Money.new(100000000) unless self.virtual_money_cents

  end

  def started?
    start_time >= Time.now
  end

end
