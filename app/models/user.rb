class User < ApplicationRecord
  # encrypt password
  has_secure_password

  has_many :conversations, foreign_key: :sender_id
  has_many :received_conversations, foreign_key: :recipient_id, class_name: 'Conversation'
end
