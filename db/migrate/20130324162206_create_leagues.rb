class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string :title
      t.text :description
      t.string :category
      t.string :market
      t.string :algo_name

      t.timestamps
    end
  end
end
