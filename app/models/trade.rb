class Trade < ActiveRecord::Base

  self.table_name = :trades

  attr_accessible :amount, :stock, :price, :type, :user_league_association, :system_created

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
      #todo remove this later
      user_league_association.league.update_positions! #if Rails.env.development?
    end

    def validate_league
      unless system_created?
        unless user_league_association.league.in_progress?
          errors[:base] << "Can't execute trade right now!"
          return false
        end
      end
    end


end
