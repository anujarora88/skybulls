module Notify

  def self.included(base)
    base.extend(ClassMethods)
    base.has_many :entity_notifications,
                  :as => :entity,
                  :class_name => 'Notification',
                  :dependent => :delete_all




  end

  def mark_as_read(user)
    Notification.update_all({:read => true}, ["entity_type = '#{self.class.name}' and entity_id = ? and user_id = ?", self.id, user.id])
  end

  def notify(user, message)
    create_or_update_entity_notifications(user, message)
  end


  private

  def create_or_update_entity_notifications(user, message)
    Delayed::Job.enqueue Jobs::MemberNotifications.new(user.id, self.class.name, self.id, message)
  end



  module ClassMethods


    def asset_type_name
      name.pluralize
    end

  end



end