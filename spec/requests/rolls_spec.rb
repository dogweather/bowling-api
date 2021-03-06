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

  describe 'GET /games/:game_id/frames/:frame_id/rolls/:id' do
    it 'works with the external id' do
      post "/games/#{new_game.id}/frames/1/rolls?score=5"
      expect(response).to have_http_status(:created)

      get "/games/#{new_game.id}/frames/1/rolls/1"
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /games/:game_id/frames/:frame_id/rolls' do
    context 'when a game has just been created' do
      it 'returns success: object created' do
        post "/games/#{new_game.id}/frames/1/rolls?score=5"
        expect(response).to have_http_status(201)
      end
    end

    it "won't permit an invalid score" do
      post "/games/#{new_game.id}/frames/1/rolls?score=50"
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "won't permit 3 rolls where only two are allowed" do
      simple_throw = "/games/#{new_game.id}/frames/1/rolls?score=8"

      post simple_throw
      expect(response).to have_http_status(:created)

      post simple_throw
      expect(response).to have_http_status(:created)

      post simple_throw
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "won't permit 3 gutter balls in the first frame" do
      gutter_ball = "/games/#{new_game.id}/frames/1/rolls?score=0"

      post gutter_ball
      expect(response).to have_http_status(:created)

      post gutter_ball
      expect(response).to have_http_status(:created)

      post gutter_ball
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'allows 3 throws in the 10th frame on a strike' do
      (1..9).each do |frame|
        2.times do
          post "/games/#{new_game.id}/frames/#{frame}/rolls?score=8"
          expect(response).to have_http_status(:created)
        end
      end

      post "/games/#{new_game.id}/frames/10/rolls?score=10"
      expect(response).to have_http_status(:created)

      post "/games/#{new_game.id}/frames/10/rolls?score=1"
      expect(response).to have_http_status(:created)

      post "/games/#{new_game.id}/frames/10/rolls?score=1"
      expect(response).to have_http_status(:created)
    end

    it 'allows 3 throws in the 10th frame on a spare' do
      (1..9).each do |frame|
        2.times do
          post "/games/#{new_game.id}/frames/#{frame}/rolls?score=5"
          expect(response).to have_http_status(:created)
        end
      end

      post "/games/#{new_game.id}/frames/10/rolls?score=5"
      expect(response).to have_http_status(:created)

      post "/games/#{new_game.id}/frames/10/rolls?score=5"
      expect(response).to have_http_status(:created)

      post "/games/#{new_game.id}/frames/10/rolls?score=1"
      expect(response).to have_http_status(:created)
    end

    it 'allows only 2 throws in the 10th frame w/out a spare or strike' do
      (1..9).each do |frame|
        2.times do
          post "/games/#{new_game.id}/frames/#{frame}/rolls?score=4"
          expect(response).to have_http_status(:created)
        end
      end

      post "/games/#{new_game.id}/frames/10/rolls?score=5"
      expect(response).to have_http_status(:created)

      post "/games/#{new_game.id}/frames/10/rolls?score=3"
      expect(response).to have_http_status(:created)

      post "/games/#{new_game.id}/frames/10/rolls?score=1"
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'disallows skipping ahead a frame' do
      (1..3).each do |frame|
        2.times do
          post "/games/#{new_game.id}/frames/#{frame}/rolls?score=4"
          expect(response).to have_http_status(:created)
        end
      end

      post "/games/#{new_game.id}/frames/8/rolls?score=5"
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'disallows skipping ahead a frame when current one is unfinished' do
      (1..3).each do |frame|
        2.times do
          post "/games/#{new_game.id}/frames/#{frame}/rolls?score=4"
          expect(response).to have_http_status(:created)
        end
      end

      post "/games/#{new_game.id}/frames/4/rolls?score=5"
      expect(response).to have_http_status(:created)

      post "/games/#{new_game.id}/frames/8/rolls?score=5"
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
