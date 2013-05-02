class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :time_zone, :string
    add_column :users, :notifications_enabled, :boolean, :default => true
  end
end
