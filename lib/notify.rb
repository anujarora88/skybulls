module Notify

  ASSET_ORDERED_LIST = %w{Announcement Event MList::Thread RepositoryFile Hub::Affiliation Hub::Photo Hub::Whiteboard}

  def self.included(base)
    base.extend(ClassMethods)
    base.has_many :entity_notifications,
                  :as => :entity,
                  :class_name => 'Notification',
                  :dependent => :delete_all




  end

  def mark_as_read
    return unless Person.current
    person = Person.current
    # keeping the entity marked as read for the current request,
    #event though it is marked as read in the db, for the current request the entity will be shown as unread to the user
    self.read = false
    Notification.update_all({:read => true}, ["entity_type = '#{self.class.name}' and entity_id = ? and person_id = ?", self.id, person.id])
  end

  def create_notification
    create_or_update_entity_notifications if notify_on_create?
    @asset_notification_created = true
  end

  def update_notification
    create_or_update_entity_notifications if notify_on_update?
    @asset_notification_created = true
  end

  def asset_title
    to_s
  end

  def asset_link
    "#"
  end

  def resolve_people_for_notification
    #using find_all to create a copy of the persistent list
    self.hub.people.find_all {|p| p != self }
  end

  def people_to_be_notified
    people = resolve_people_for_notification
    people = people + hub.organization.admins if respond_to?(:hub) && auto_notify_organization_admin?
    people.uniq
  end


  private

  # automatically adding the organization admins to the resolved people if auto_notify_organization_admin?
  # @asset_notification_created is being used to make this filter out duplicates, the MList::Thread entity was calling this
  # method a huge no. of times in a single request for some weird reason
  def create_or_update_entity_notifications
    return if @asset_notification_created
    actor_id = Person.current ? Person.current.id : nil
    Delayed::Job.enqueue Jobs::MemberNotifications.new(actor_id, self.class.name, self.id)
  end


  def notify_on_update?
    true
  end

  def auto_notify_organization_admin?
    true
  end

  def notify_on_create?
    true
  end

  def asset_type_url
    ""
  end

  module ClassMethods

    def mark_all_as_read(entities, hub)
      entity_list = entities.nil? ? [] : entities
      return unless Person.current && !entity_list.empty?
      entities.each{|e| e.read = false}
      Notification.update_all({:read => true}, ["entity_type = '#{self.name}' and entity_id IN (?) and person_id = ?", entity_list.collect(&:id), Person.current.id])
    end

    def asset_type_name
      name.pluralize
    end

  end



end