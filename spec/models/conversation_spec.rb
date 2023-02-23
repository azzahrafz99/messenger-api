require 'rails_helper'

RSpec.describe Conversation, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:recipient).class_name('User') }
    it { is_expected.to belong_to(:sender).class_name('User') }

    it { is_expected.to have_many(:chats) }
  end

  describe '#between' do
    let(:user)  { create(:user) }
    let(:user2) { create(:user) }
    let(:user3) { create(:user) }

    let!(:conversation)  { create(:conversation, sender: user, recipient: user2) }
    let!(:conversation2) { create(:conversation, sender: user2, recipient: user3) }

    it 'returns conversation between users' do
      expect(Conversation.between(user, user2)).to include(conversation)
      expect(Conversation.between(user2, user3)).to include(conversation2)
      expect(Conversation.between(user, user3)).to be_empty
    end
  end
end
