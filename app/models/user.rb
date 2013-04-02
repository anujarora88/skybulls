class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  has_many :authentications, :dependent => :delete_all
  has_many :user_leagues
  has_many :leagues , :through => :user_leagues


  has_one :account, :class_name => 'User::Account'

  devise :omniauthable, :omniauth_providers => [:facebook, :google]

  before_create :initialize_account

  def apply_omniauth(auth, email_address = nil)
    # In previous omniauth, 'user_info' was used in place of 'raw_info'
    self.email = email_address || auth['extra']['raw_info']['email']
    # Again, saving token is optional. If you haven't created the column in authentications table, this will fail
    authentications.build(:provider => auth['provider'], :uid => auth['uid'], :token => auth['credentials']['token'])
  end


  def self.find_for_open_id(access_token, signed_in_resource=nil)
    data = access_token.info
    if user = User.where(:email => data["email"]).first
      user
    else
      User.create!(:email => data["email"], :password => Devise.friendly_token[0,20])
    end
  end

  private

    def initialize_account
        build_account(:balance => Money.new(0))
    end
end
