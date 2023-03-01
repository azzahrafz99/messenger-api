class Conversation < ApplicationRecord
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'

  has_many :chats

  def unread_chats(current_user)
    chats.where(read_at: nil).where.not(sender: current_user)
  end

  def user(current_user)
    sender.eql?(current_user) ? recipient : sender
  end

  def self.between(sender_id, recipient_id)
    where(sender_id: sender_id, recipient_id: recipient_id)
      .or(where(sender_id: recipient_id, recipient_id: sender_id))
  end
end
