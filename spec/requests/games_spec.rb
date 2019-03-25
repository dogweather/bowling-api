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

  # describe 'PUT /games' do

  # end
end
