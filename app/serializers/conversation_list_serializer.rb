class ConversationListSerializer < ActiveModel::Serializer
  attributes :id, :with_user, :last_message, :unread_count

  def with_user
    object.sender.as_json
  end

  def last_message
    last_chat = chats.last

    {
      id: last_chat.id,
      sender: last_chat.sender_as_json,
      sent_at: last_chat.created_at
    }
  end

  def unread_count
    chats.where(sender: object.recipient, read_at: nil).count
  end

  private

  def chats
    object.chats
  end
end
