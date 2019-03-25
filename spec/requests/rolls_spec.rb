# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Rolls', type: :request do
  let(:new_game) { Game.create! }

  describe 'GET /games/:game_id/frames/:frame_id/rolls' do
    context 'when a game has just been created' do
      before { get "/games/#{new_game.id}/frames/1/rolls" }

      it 'returns success' do
        expect(response).to have_http_status(200)
      end

      it 'returns an empty list' do
        expect(JSON.parse(response.body)).to eq([])
      end
    end
  end

  describe 'POST /games/:game_id/frames/:frame_id/rolls' do
    it 'returns Unprocessable Entity if the roll has an invalid score' do
      post "/games/#{new_game.id}/frames/1/rolls?score=50"
      expect(response).to have_http_status(:unprocessable_entity)
    end

    context 'when a game has just been created' do
      before { post "/games/#{new_game.id}/frames/1/rolls?score=5" }

      it 'returns success: object created' do
        expect(response).to have_http_status(201)
      end
    end
  end
end
