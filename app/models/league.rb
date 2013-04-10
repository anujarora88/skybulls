class League < ActiveRecord::Base
  has_many :user_league_associations
  has_many :users , :through => :user_leagues
  has_many :allowed_exchange ,:class_name => 'Exchange'
  attr_accessible :algo_name, :category, :description, :market, :title, :users
end
