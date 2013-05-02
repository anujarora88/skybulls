class LeagueObserver < ActiveRecord::Observer
  # To change this template use File | Settings | File Templates.
  observe :league

  def after_create(league)
    obj = Jobs.enqueue(Jobs::LeagueStartJob.new(league.id), run_at: league.start_time)
    league.start_job_id = obj.id
    obj = Jobs.enqueue(Jobs::LeagueEndJob.new(league.id), run_at: league.end_time)
    league.end_job_id = obj.id
    league.save!
  end

  def after_update(league)
    unless league.started?
      if league.start_time_changed?
        job = Delayed::Job.find(league.start_job_id)
        if job
          job.run_at = league.start_time
          job.save!
        end
      end
    end
    unless league.completed
      if league.end_time_changed?
        job = Delayed::Job.find(league.end_job_id)
        if job
          job.run_at = league.end_time
          job.save!
        end
      end
    end
  end


end