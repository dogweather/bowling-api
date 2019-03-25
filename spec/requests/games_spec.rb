# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Games', type: :request do
  let(:new_game) { Game.create! }

  describe 'GET /games' do
    before { get '/games' }

    it 'is successful' do
      expect(response).to have_http_status(200)
    end

    it 'returns content-type json' do
      expect(response.content_type).to eq('application/json')
    end

    it 'returns an array of game objects' do
      content = JSON.parse(response.body)

      expect(content).to be_an(Array)
    end
  end

  describe 'POST /games' do
    before { post '/games' }

    it 'returns status: object created' do
      expect(response).to have_http_status(201)
    end

    it 'returns the new Game id' do
      newest_id = Game.order('id DESC').limit(1).pluck(:id).first
      actual_id = JSON.parse(response.body)['id']

      expect(actual_id).to eq(newest_id)
    end
  end

  describe 'GET /game/:game_id' do
    it "doesn't return a score when the game is new" do
      get "/games/#{new_game.id}"
      attributes = JSON.parse(response.body).keys

      expect(response).to have_http_status(200)
      expect(attributes).not_to include('score')
    end

    it "doesn't return a score when the game has started but not finished" do
      # Player rolls a 5 and a 2 in the first frame
      post "/games/#{new_game.id}/frames/1/rolls?score=5"
      post "/games/#{new_game.id}/frames/1/rolls?score=2"
      # Check the game info
      get "/games/#{new_game.id}"

      attributes = JSON.parse(response.body).keys

      expect(response).to have_http_status(200)
      expect(attributes).not_to include('score')
    end

    it 'returns a score when the game is finished' do
      # Bowl ten frames
      (1..10).each do |frame|
        post "/games/#{new_game.id}/frames/#{frame}/rolls?score=5"
        post "/games/#{new_game.id}/frames/#{frame}/rolls?score=2"
      end

      # Check the game info
      get "/games/#{new_game.id}"
      expect(response).to have_http_status(200)

      score = JSON.parse(response.body)['score']
      expect(score).to eq(70)
    end
  end

  describe 'DELETE /games/:id' do
    it 'is successful when game exists' do
      delete "/games/#{new_game.id}"
      expect(response).to have_http_status(204)
    end
  end
end
