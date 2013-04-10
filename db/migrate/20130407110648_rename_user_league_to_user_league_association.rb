class RenameUserLeagueToUserLeagueAssociation < ActiveRecord::Migration
  def up
    rename_table :user_leagues, :user_league_associations
  end

  def down
  end
end
