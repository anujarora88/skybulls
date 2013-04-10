class Exchange < ActiveRecord::Base
  attr_accessible :ends_at, :logo_url, :name, :starts_at, :symbol
  has_many :stocks

  has_and_belongs_to_many :leagues
end
