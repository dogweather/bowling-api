# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Frames', type: :request do
  describe 'GET /games/:game_id/frames' do
    it 'returns success' do
      game = Game.create!

      get "/games/#{game.id}/frames"
      expect(response).to have_http_status(200)
    end
  end
end
