class ChatSerializer < ActiveModel::Serializer
  attributes :id, :message, :sender, :sent_at, :conversation

  def sender
    object.sender_as_json
  end

  def conversation
    conversation = object.conversation
    convo_sender = conversation.sender
    user         = object.sender.eql?(convo_sender) ? conversation.recipient : convo_sender

    { id: conversation.id, with_user: user.as_json }
  end
end
