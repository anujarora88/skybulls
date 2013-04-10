class UpdateLeagueTable < ActiveRecord::Migration
  def up
    add_column :leagues , :start_time , :datetime
    add_column :leagues , :end_time , :datetime
    add_column :leagues , :latest_registration_time , :datetime ,:default => nil
    add_column :leagues , :invitation_only , :boolean ,:default => false
    add_column :leagues , :buy_in , :float
    add_column :leagues , :commission , :float
    add_column :leagues , :min_users , :integer
    add_column :leagues , :max_users , :integer

  end

  def down
    remove_column :leagues , :start_time , :datetime
    remove_column :leagues , :end_time , :datetime
    remove_column :leagues , :latest_registration_time , :datetime ,:default => nil
    remove_column :leagues , :invitation_only , :boolean ,:default => false
    remove_column :leagues , :buy_in , :float
    remove_column :leagues , :buy_in , :float
    remove_column :leagues , :min_users , :integer
    remove_column :leagues , :max_users , :integer
  end
end
