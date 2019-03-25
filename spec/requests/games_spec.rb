# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Games', type: :request do
  let(:new_game) { Game.create! }
  let(:headers) { { 'ACCEPT' => 'application/json' } }

  describe 'GET /games' do
    before { get '/games', headers: headers }

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
    before { post '/games', headers: headers }

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
      get "/games/#{new_game.id}"
      attributes = JSON.parse(response.body).keys

      expect(response).to have_http_status(200)
      expect(attributes).not_to include('score')
    end
  end
end
