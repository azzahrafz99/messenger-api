class ChatsController < ApplicationController
  def create
    chat = Chat.new(chat_params)
    return json_response(chat_serializer(chat), :created) if chat.save

    json_response({ errors: chat.errors }, :unprocessable_entity)
  end

  private

  def recipient
    User.find(params[:user_id])
  end

  def chat_params
    {
      conversation: chat_conversation, sender: @current_user,
      message: params[:message]
    }
  end

  def chat_serializer(chat)
    ActiveModelSerializers::SerializableResource.new \
      chat, serializer: ChatSerializer, current_user: @current_user
  end

  def chat_conversation
    conversation = Conversation.between(@current_user.id, recipient.id)
    conversation.present? ? conversation.first : create_conversation
  end

  def create_conversation
    Conversation.create(sender_id: @current_user.id, recipient_id: recipient.id)
  end
end
