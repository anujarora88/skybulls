class Bid < ActiveRecord::Base
  attr_accessible :amount, :stock, :trade_id, :type, :user_league_association, :price

  monetize :price_cents, :allow_nil => false, :numericality => {
      :greater_than_or_equal_to => 0
  }

  belongs_to :stock
  belongs_to :user_league_association

  belongs_to :trade

  monetize :price_cents, :allow_nil => false, :numericality => {
      :greater_than_or_equal_to => 0
  }

  validates_presence_of :stock_id, :type, :user_league_association_id

  before_save :validate_league


  def completed?
    !trade_id.nil?
  end

  def validate_league
    errors.add(:base, "Can't execute trade right now!") unless user_league_association.league.in_progress?
  end

end
