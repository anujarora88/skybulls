class AddAggregateFieldsToStock < ActiveRecord::Migration
  def change
    add_column :stocks, :change, :float
    add_column :stocks, :percentage_change, :float
  end
end
