class AddedCompletedFlagToLeague < ActiveRecord::Migration
  def change

    remove_column :user_league_associations, :completed
    add_column :leagues, :completed, :boolean, :default => false
    change_table :user_league_associations do |t|
      t.money :investment
    end


  end
end
