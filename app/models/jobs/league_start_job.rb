module Jobs
  class LeagueStartJob < Struct.new(:league_id)
    include ErrorTracking

    def perform
      league = League.find(league_id)
      if league
        league.users.each do |u|
          league.notify(u, "The #{league.title} league has just started!")
          UserMailer.league_start_email(u,league)
        end
      end
    end

  end
end
