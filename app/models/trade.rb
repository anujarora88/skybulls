class Trade < ActiveRecord::Base

  self.table_name = :trades

  attr_accessible :amount, :stock, :price, :type, :user_league_association

  belongs_to :stock
  belongs_to :user_league_association

  monetize :price_cents, :allow_nil => false, :numericality => {
      :greater_than_or_equal_to => 0
  }

  validates_presence_of :stock_id, :type, :user_league_association_id

  has_one :bid

  before_save :validate_league
  after_create :update_balance
  after_create :update_league_position

  private

    def update_balance
      raise 'abstract method'
    end

    def update_league_position
      user_league_association.league.update_positions! if Rails.env.development?
    end

    def validate_league
      unless system_created?
        errors.add(:base, "League has already ended!") unless user_league_association.league.in_progress?
      end
    end


end
