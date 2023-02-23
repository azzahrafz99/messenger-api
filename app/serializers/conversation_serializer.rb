class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :with_user

  def with_user
    sender = object.sender

    {
      id: sender.id,
      name: sender.name,
      photo_url: sender.photo_url
    }
  end
end
