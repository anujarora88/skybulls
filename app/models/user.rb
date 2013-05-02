class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :user_name, :phone_number, :time_zone, :notifications_enabled
  # attr_accessible :title, :body
  has_many :authentications, :dependent => :delete_all
  has_many :user_league_associations
  has_many :leagues , :through => :user_league_associations
=begin
  has_attached_file :photo, :styles => { :small => "150x150>" },
                    :url  => "/assets/users/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/users/:id/:style/:basename.:extension"

  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
=end

  has_many :notifications,
           :dependent => :delete_all
  has_many :user_stock_associations
  has_many :stocks, :through => :user_stock_associations

  has_one :account, :class_name => 'Users::Account'

  devise :omniauthable, :omniauth_providers => [:facebook, :google]

  before_create :initialize_account

  def display_name
    user_name || email
  end

  def league_association(league)
    user_league_associations.where(league_id: league.id).first
  end



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

  def image_url
    "https://graph.facebook.com/#{facebook_id}/picture?type=normal" if facebook_id
  end

  def large_image_url
    "https://graph.facebook.com/#{facebook_id}/picture?type=large" if facebook_id
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end


  # Check if user connected social network
  def social_connected?(social_name)
    authentication_providers.include?(social_name)
  end


  def authentication_providers
    @authentication_providers ||= Authentication.where(:user_id => self.id).map(&:provider)
  end

  def facebook_id
    @facebook_id ||= Authentication.where(:user_id => self.id, :provider => 'facebook').first.try(:uid)
  end

  def pinned_stock?(stock)
    user_stock_associations.collect(&:stock).include? stock
  end

  def pinned_stocks
     user_stock_associations.order("updated_at desc").all.collect(&:stock)
  end

  def add_pinned_stock(stock, recently_searched = false)
    raise "Stock is nil" if stock.nil?
    user_stock = user_stock_associations.find_or_create_by_stock_id(stock.id)
    user_stock.recently_searched= recently_searched unless recently_searched
    user_stock.save!
  end

  def delete_pinned_stock(stock)
    raise "Stock is nil" if stock.nil?
    user_stock = user_stock_associations.find_by_stock_id(stock.id)
    user_stock.destroy if user_stock
  end

  private

    def initialize_account
        acc = build_account()
        acc.balance = Money.new(0)

    end
end
