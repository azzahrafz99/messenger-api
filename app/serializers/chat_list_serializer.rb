class ChatListSerializer < ActiveModel::Serializer
  attributes :id, :message, :sender, :sent_at

  def sender
    object.sender_as_json
  end
end
