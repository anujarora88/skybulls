module Jobs
  class MemberNotifications < Struct.new(:user_id, :entity_type, :entity_id, :message)
    include ErrorTracking

    def perform
      user = User.find(user_id)
      entity = entity_type.constantize.find(entity_id)
      create_or_update_notification(user, entity, message) if user.notifications_enabled?
    end

    private

    def create_or_update_notification(member, entity, message)
      return unless member && entity
      notifications = Notification.where(["entity_type = ? AND entity_id = ? AND user_id = ?", entity.class.name, entity.id, member.id]).all
      if notifications.empty?
        Notification.new(:entity => entity, :user => member, :message => message).save!
      else
        notifications.each{|n| n.update_attribute("read", false)}
      end
    end


  end
end
