class ConversationListSerializer < ActiveModel::Serializer
  attributes :id, :with_user, :last_message, :unread_count

  def with_user
    object.user(current_user).as_json
  end

  def last_message
    last_chat = object.chats.last

    {
      id: last_chat.id,
      sender: last_chat.sender_as_json,
      sent_at: last_chat.created_at
    }
  end

  def unread_count
    object.unread_chats(current_user).count
  end

  private

  def current_user
    @instance_options[:current_user]
  end
end
