class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.boolean :read, :default => false, :null => false
      t.belongs_to :user, :null => false
      t.belongs_to :entity, :polymorphic => true, :null => false
      t.string :message
      t.timestamps
    end
  end
end
