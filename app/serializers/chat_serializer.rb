class ChatSerializer < ActiveModel::Serializer
  attributes :id, :message, :sender, :sent_at, :conversation

  def sender
    object.sender_as_json
  end

  def conversation
    ActiveModelSerializers::SerializableResource.new \
      object.conversation, serializer: ConversationSerializer,
      current_user: current_user
  end

  private

  def current_user
    @instance_options[:current_user]
  end
end
