class ChatListSerializer < ActiveModel::Serializer
  attributes :id, :message, :sender, :send_at

  def sender
    sender = object.sender
    { id: sender.id, name: sender.name }
  end

  def send_at
    object.created_at
  end
end
