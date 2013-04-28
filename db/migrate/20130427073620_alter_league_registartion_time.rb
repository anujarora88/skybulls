class AlterLeagueRegistartionTime < ActiveRecord::Migration
  def up
    change_column :leagues, :latest_registration_time, :integer
  end

  def down
  end
end
