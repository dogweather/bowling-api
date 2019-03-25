# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Rolls', type: :request do
  fixtures :games

  describe 'GET /games/:game_id/frames/:frame_id/rolls' do
    context 'when a game has just been created' do
      before { get "/games/#{games(:new_game).id}/frames/1/rolls" }

      it 'returns success' do
        expect(response).to have_http_status(200)
      end

      it 'returns an empty list' do
        expect(JSON.parse(response.body)).to eq([])
      end
    end
  end

  describe 'POST /games/:game_id/frames/:frame_id/rolls' do
    context 'when a game has just been created' do
      before { post "/games/#{games(:new_game).id}/frames/1/rolls?score=5" }

      xit 'returns success: object created' do
        expect(response).to have_http_status(201)
      end
    end
  end
end
