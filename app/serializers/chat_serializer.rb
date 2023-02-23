class ChatSerializer < ActiveModel::Serializer
  attributes :id, :message, :sender, :sent_at, :conversation

  def sender
    sender = object.sender
    { id: sender.id, name: sender.name }
  end

  def sent_at
    object.created_at
  end

  def conversation
    conversation = object.conversation
    convo_sender = conversation.sender
    user         = object.sender.eql?(convo_sender) ? conversation.recipient : convo_sender

    {
      id: conversation.id,
      with_user: { id: user.id, name: user.name, photo_url: user.photo_url }
    }
  end
end
