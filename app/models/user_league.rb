class UserLeague < ActiveRecord::Base
  attr_accessible :league_id, :user_id

  belongs_to :user
  belongs_to :league
end
