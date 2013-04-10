class League < ActiveRecord::Base
  has_many :user_league_associations
  has_many :users , :through => :user_leagues
  has_and_belongs_to_many :exchanges
  attr_accessible :algo_name, :category, :description, :market, :title, :users
end
