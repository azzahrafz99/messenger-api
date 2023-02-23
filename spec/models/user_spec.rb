require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { is_expected.to have_many(:conversations) }
    it { is_expected.to have_many(:received_conversations) }
  end
end
