class ConversationSerializer < ActiveModel::Serializer
  attributes :id, :with_user

  def with_user
    object.user(current_user).as_json
  end

  private

  def current_user
    @instance_options[:current_user]
  end
end
