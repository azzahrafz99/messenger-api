class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :with_user

  def with_user
    object.recipient.as_json
  end
end
