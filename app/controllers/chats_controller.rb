class ChatsController < ApplicationController
  def create
    return response_message_empty if message.blank?

    chat = Chat.new(conversation: chat_conversation, sender: @current_user, message: message)
    return json_response(chat_serializer(chat), :created) if chat.save

    json_response({ errors: chat.errors }, :unprocessable_entity)
  end

  private

  def recipient
    User.find(params[:user_id])
  end

  def response_message_empty
    json_response({ error: 'Invalid Request' }, :unprocessable_entity)
  end

  def message
    params[:message]
  end

  def chat_serializer(chat)
    ActiveModelSerializers::SerializableResource.new(chat, serializer: ChatSerializer)
  end

  def chat_conversation
    conversation = Conversation.where(sender_id: @current_user.id, recipient_id: recipient.id)
                               .or(Conversation.where(sender_id: recipient.id,
                                                      recipient_id: @current_user.id))
                               .first

    conversation.present? ? conversation : create_conversation
  end

  def create_conversation
    Conversation.create(sender_id: @current_user.id, recipient_id: recipient.id)
  end
end
