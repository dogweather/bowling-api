# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Games', type: :request do
  fixtures :games
  let(:headers) { { 'ACCEPT' => 'application/json' } }

  describe 'GET /games' do
    it 'is successful' do
      get '/games', headers: headers
      expect(response).to have_http_status(200)
    end

    it 'returns content-type json' do
      get '/games', headers: headers
      expect(response.content_type).to eq('application/json')
    end

    it 'returns an array of game objects' do
      get '/games', headers: headers
      expect(JSON.parse(response.body).first['id']).to eq(games(:new_game).id)
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
end
