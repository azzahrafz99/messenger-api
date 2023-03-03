class ConversationsController < ApplicationController
  before_action :conversation, only: [:show, :messages]

  def index
    conversations = @current_user.conversations
    return json_response([]) unless conversations.present?

    json_response(conversation_list_serializer(conversations))
  end

  def show
    owner? ? json_response(conversation_serializer) : unauthorized_response
  end

  def messages
    owner? ? json_response(chat_list_serializer) : unauthorized_response
  end

  private

  def conversation_list_serializer(conversations)
    ActiveModelSerializers::SerializableResource.new(conversations,
                                                     each_serializer: ConversationListSerializer,
                                                     current_user: @current_user)
  end

  def conversation_serializer
    ActiveModelSerializers::SerializableResource.new(conversation,
                                                     serializer: ConversationSerializer)
  end

  def chat_list_serializer
    ActiveModelSerializers::SerializableResource.new(conversation.chats,
                                                     each_serializer: ChatListSerializer)
  end

  def conversation
    @conversation ||= Conversation.find(params[:id])
  end

  def owner?
    conversation.sender.eql?(@current_user) || conversation.recipient.eql?(@current_user)
  end

  def unauthorized_response
    json_response({ error: Message.unauthorized }, :forbidden)
  end
end
