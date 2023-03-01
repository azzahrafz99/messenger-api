class Chat < ApplicationRecord
  belongs_to :conversation
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'

  def sent_at
    created_at
  end

  def sender_as_json
    { id: sender.id, name: sender.name }
  end
end
