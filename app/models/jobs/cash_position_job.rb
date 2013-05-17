module Jobs
  class CashPositionJob < Struct.new(:ula_id)
    include ErrorTracking

    def perform
        ula = UserLeagueAssociation.find(ula_id)
        if ula
          league = ula.league
          user = ula.user
          league.notify(user,"You finished the league in #{@ula.rank} place")
          UserMailer.cash_position_email(ula)
        end
    end
  end
end
