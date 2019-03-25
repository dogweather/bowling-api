# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Frames', type: :request do
  let(:new_game) { Game.create! }

  describe 'GET /games/:game_id/frames' do
    it 'returns success' do
      get "/games/#{new_game.id}/frames"
      expect(response).to have_http_status(200)
    end

    it 'returns content-type json' do
      get "/games/#{new_game.id}/frames"
      expect(response.content_type).to eq('application/json')
    end

    it 'returns a list of ten frames for a new game' do
      get "/games/#{new_game.id}/frames"
      frame_count = JSON.parse(response.body).size
      expect(frame_count).to eq(10)
    end
  end

  describe 'GET /games/:game_id/frames/:id' do
    (1..10).each do |frame_id|
      it 'works with the "external id"' do
        get "/games/#{new_game.id}/frames/#{frame_id}"
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
