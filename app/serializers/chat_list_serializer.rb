class ChatListSerializer < ActiveModel::Serializer
  attributes :id, :message, :sender, :sent_at

  def sender
    sender = object.sender
    { id: sender.id, name: sender.name }
  end

  def sent_at
    object.created_at
  end
end
