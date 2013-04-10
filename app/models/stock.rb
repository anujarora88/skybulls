class Stock < ActiveRecord::Base
  attr_accessible :latest_price, :symbol
  belongs_to :company
  belongs_to :exchange
end
