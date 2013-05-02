module Jobs
  class LeagueStartJob < Struct.new(:league_id)
    include ErrorTracking

    def perform
      league = League.find(league_id)
      if league
        league.users.each do |u|
          league.notify(u, "The league has just started!")
        end
      end
    end

  end
end
