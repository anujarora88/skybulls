class UserStockAssociation < ActiveRecord::Base

  attr_accessible :stock, :user, :recently_searched


  belongs_to :user
  belongs_to :stock

  before_save :default_values

  def default_values
    self.recently_searched ||= false
  end

end
