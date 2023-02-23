require 'rails_helper'

RSpec.describe Conversation, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:recipient).class_name('User') }
    it { is_expected.to belong_to(:sender).class_name('User') }
  end
end
