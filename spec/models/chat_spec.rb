require 'rails_helper'

RSpec.describe Chat, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:conversation) }
    it { is_expected.to belong_to(:sender).class_name('User') }
  end

  describe '#unread' do
    let!(:chat)  { create(:chat, read_at: Time.current) }
    let!(:chat2) { create(:chat) }

    let(:unread_chats) { Chat.unread }

    it 'returns unread chats only' do
      expect(unread_chats).not_to include chat
      expect(unread_chats).to include chat2
    end
  end
end
