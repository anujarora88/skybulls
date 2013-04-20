class UserLeagueAssociation < ActiveRecord::Base
  attr_accessible :league_id, :user_id

  belongs_to :user
  belongs_to :league

  has_many :trades
  has_many :bids
end
