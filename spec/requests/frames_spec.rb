# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Frames', type: :request do
  fixtures :games
  let(:headers) { { 'ACCEPT' => 'application/json' } }

  describe 'GET /games/:game_id/frames' do
    it 'returns success' do
      get "/games/#{games(:new_game).id}/frames", headers: headers
      expect(response).to have_http_status(200)
    end

    it 'returns content-type json' do
      get "/games/#{games(:new_game).id}/frames", headers: headers
      expect(response.content_type).to eq('application/json')
    end

    it 'returns an empty list for a new game' do
      get "/games/#{games(:new_game).id}/frames"
      expect(response.body).to eq('[]')
    end
  end
end
