class LeagueJobs < ActiveRecord::Migration
  def change
    add_column :leagues, :start_job_id, :integer
    add_column :leagues, :end_job_id, :integer
  end
end
