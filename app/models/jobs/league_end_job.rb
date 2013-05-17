module Jobs
  class LeagueEndJob < Struct.new(:league_id)
    include ErrorTracking

    def perform
      league = League.find(league_id)
      # execute all open trades, and update_positions
      if league
        ActiveRecord::Base.transaction do
          league.execute_open_trades!
          league.pay_winners!
          ula = UserLeagueAssociation.where(:league_id=>league_id,:rank => 1)
          Jobs.enqueue(Jobs::CashPositionJob.new(ula.id))
          league.completed = true
          league.save!
        end

      end
    end

  end
end
