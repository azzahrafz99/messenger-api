class User < ApplicationRecord
  # encrypt password
  has_secure_password

  has_many :conversations, foreign_key: :sender_id
  has_many :received_conversations, foreign_key: :recipient_id, class_name: 'Conversation'
  has_many :chats, through: :conversations
  has_many :received_chats, through: :received_conversations, source: :chats
end
