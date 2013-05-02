class AddVirtualMoneyToLeague < ActiveRecord::Migration
  def change
    change_table :leagues do |t|
      t.money :virtual_money
    end
  end
end
