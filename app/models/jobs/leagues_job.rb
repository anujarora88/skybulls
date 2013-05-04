module Jobs
  class LeaguesJob
    include ErrorTracking

    def perform
      Rails.logger.info("Starting leagues job!")
      leagues = League.where({completed: false})
      leagues.each do |l|
        l.update_positions! if l.in_progress?
      end

    end

  end
end
