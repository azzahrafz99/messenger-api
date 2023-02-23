require 'rails_helper'

RSpec.describe 'Conversations API', type: :request do
  let(:dimas) { create(:user) }
  let(:dimas_headers) { valid_headers(dimas.id) }

  let(:samid) { create(:user) }
  let(:samid_headers) { valid_headers(samid.id) }

  describe 'GET /conversations' do
    context 'when user have no conversation' do
      # make HTTP get request before each example
      before { get '/conversations', params: {}, headers: dimas_headers }

      it 'returns empty data with 200 code' do
        expect_response(
          :ok,
          data: []
        )
      end
    end

    context 'when user have conversations' do
      # TODOS: Populate database with conversation of current user
      let(:convo)  { create :conversation, sender: dimas, recipient: samid }
      let(:convo2) { create :conversation, sender: dimas, recipient: samid }
      let(:convo3) { create :conversation, sender: dimas, recipient: samid }
      let(:convo4) { create :conversation, sender: dimas, recipient: samid }
      let(:convo5) { create :conversation, sender: dimas, recipient: samid }

      let!(:chat)  { create(:chat, sender: samid, conversation: convo) }
      let!(:chat2) { create(:chat, sender: dimas, conversation: convo2) }
      let!(:chat3) { create(:chat, sender: samid, conversation: convo3) }
      let!(:chat4) { create(:chat, sender: samid, conversation: convo4) }
      let!(:chat5) { create(:chat, sender: dimas, conversation: convo5) }

      before { get '/conversations', params: {}, headers: dimas_headers }

      it 'returns list conversations of current user' do
        # Note `response_data` is a custom helper
        # to get data from parsed JSON responses in spec/support/request_spec_helper.rb

        expect(response_data).not_to be_empty
        expect(response_data.size).to eq(5)
      end

      it 'returns status code 200 with correct response' do
        expect_response(
          :ok,
          data: [
            {
              id: Integer,
              with_user: {
                id: Integer,
                name: String,
                photo_url: String
              },
              last_message: {
                id: Integer,
                sender: {
                  id: Integer,
                  name: String
                },
                sent_at: String
              },
              unread_count: Integer
            }
          ]
        )
      end
    end
  end

  describe 'GET /conversations/:id' do
    let(:convo) { create :conversation, sender: dimas }

    context 'when the record exists' do
      # TODO: create conversation of dimas
      before { get "/conversations/#{convo.id}", params: {}, headers: dimas_headers }

      it 'returns conversation detail' do
        expect_response(
          :ok,
          data: {
            id: Integer,
            with_user: {
              id: Integer,
              name: String,
              photo_url: String
            }
          }
        )
      end
    end

    context 'when current user access other user conversation' do
      before { get "/conversations/#{convo.id}", params: {}, headers: samid_headers }

      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
    end

    context 'when the record does not exist' do
      before { get '/conversations/-11', params: {}, headers: dimas_headers }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
end
