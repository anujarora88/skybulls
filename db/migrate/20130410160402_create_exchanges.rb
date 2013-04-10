class CreateExchanges < ActiveRecord::Migration
  def change
    create_table :exchanges do |t|
      t.string :name
      t.string :logo_url
      t.string :symbol
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps
    end
  end
end
