class ConversationsController < ApplicationController
  before_action :conversation, only: :show

  def index
    @conversations = ActiveModelSerializers::SerializableResource.new \
      @current_user.conversations, each_serializer: ConversationListSerializer

    json_response(@conversations)
  end

  def show
    if conversation.sender.eql? @current_user
      json_response(show_conversation_serializer)
    else
      json_response({ error: 'Unauthorized Access' }, :forbidden)
    end
  end

  private

  def show_conversation_serializer
    ActiveModelSerializers::SerializableResource.new(conversation,
                                                     serializer: ConversationSerializer)
  end

  def conversation
    @conversation ||= Conversation.find(params[:id])
  end
end
