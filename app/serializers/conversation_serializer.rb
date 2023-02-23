class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :with_user

  def with_user
    user = object.recipient

    {
      id: user.id,
      name: user.name,
      photo_url: user.photo_url
    }
  end
end
