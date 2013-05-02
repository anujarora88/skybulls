class AddedSystemFlagToTrade < ActiveRecord::Migration
  def change

    add_column :trades, :system_created, :boolean
  end


end
