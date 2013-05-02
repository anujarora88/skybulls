class Notification < ActiveRecord::Base

  attr_accessible :user, :entity, :message, :read?

  belongs_to :user
  belongs_to :entity, :polymorphic => true

  validates_presence_of :user, :entity


end
