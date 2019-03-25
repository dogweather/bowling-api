# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Frames', type: :request do
  let(:headers) { { 'ACCEPT' => 'application/json' } }
  let(:new_game) { Game.create! }

  describe 'GET /games/:game_id/frames' do
    it 'returns success' do
      get "/games/#{new_game.id}/frames", headers: headers
      expect(response).to have_http_status(200)
    end

    it 'returns content-type json' do
      get "/games/#{new_game.id}/frames", headers: headers
      expect(response.content_type).to eq('application/json')
    end

    it 'returns a list of ten frames for a new game' do
      get "/games/#{new_game.id}/frames"
      frame_count = JSON.parse(response.body).size
      expect(frame_count).to eq(10)
    end
  end
end
