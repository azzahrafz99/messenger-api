class ConversationsController < ApplicationController
  before_action :conversation, only: :show

  def index
    @conversations = ActiveModelSerializers::SerializableResource.new \
      @current_user.conversations, each_serializer: ConversationListSerializer

    json_response(@conversations)
  end

  def show
    return json_response(conversation_serializer) if owner?

    json_response({ error: 'Unauthorized Access' }, :forbidden)
  end

  private

  def conversation_serializer
    ActiveModelSerializers::SerializableResource.new(conversation,
                                                     serializer: ConversationSerializer)
  end

  def conversation
    @conversation ||= Conversation.find(params[:id])
  end

  def owner?
    conversation.sender.eql? @current_user
  end
end
