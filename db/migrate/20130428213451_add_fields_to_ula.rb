class AddFieldsToUla < ActiveRecord::Migration
  def change
    change_table :user_league_associations do |t|
      t.money :balance
      t.boolean :completed, :default => false
      t.integer :rank
    end

    change_table :leagues do |t|
      t.money :virtual_money
    end
  end
end
