class CleanupDb < ActiveRecord::Migration
  def change

    change_column :user_league_associations, :league_id, :integer, :null => false
    change_column :user_league_associations, :user_id,:integer, :null => false

    add_foreign_key :user_league_associations, :users
    add_foreign_key :user_league_associations, :leagues

    remove_column :leagues, :description
    remove_column :leagues, :market
    change_column :leagues, :title, :string, :null => false
    change_column :leagues, :category, :string, :null => false
    change_column :leagues, :buy_in, :float, :null => false
    change_column :leagues, :commission, :float, :null => false
    change_column :leagues, :start_time, :datetime, :null => false
    change_column :leagues, :end_time, :datetime, :null => false

  end
end
