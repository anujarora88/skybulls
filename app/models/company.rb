class Company < ActiveRecord::Base
  attr_accessible :logo_url, :name
  has_many :stocks
end
