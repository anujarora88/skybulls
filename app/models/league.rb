class League < ActiveRecord::Base
  has_many :user_leagues
  has_many :users , :through => :user_leagues
  attr_accessible :algo_name, :category, :description, :market, :title, :users
end
