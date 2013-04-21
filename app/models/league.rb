class League < ActiveRecord::Base
  has_many :user_league_associations
  has_many :users , :through => :user_league_associations
  has_and_belongs_to_many :exchanges
  attr_accessible :algo_name, :category, :description, :market, :title, :users, :start_time, :end_time, :latest_registration_time, :commission, :invitation_only, :buy_in, :max_users, :min_users

  def started?
    start_time >= Time.now
  end

end
