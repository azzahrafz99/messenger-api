require 'rails_helper'

RSpec.describe Chat, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:conversation) }
    it { is_expected.to belong_to(:sender).class_name('User') }
  end
end
