class ConversationListSerializer < ActiveModel::Serializer
  attributes :id, :with_user, :last_message, :unread_count

  def with_user
    sender = object.sender

    {
      id: sender.id,
      name: sender.name,
      photo_url: sender.photo_url
    }
  end

  def last_message
    last_chat = chats.last

    {
      id: last_chat.id,
      sender: {
        id: last_chat.sender.id,
        name: last_chat.sender.name
      },
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
