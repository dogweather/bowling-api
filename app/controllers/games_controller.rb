# frozen_string_literal: true

class GamesController < ApplicationController
  before_action :set_game, only: %i[show destroy]

  # GET /games
  def index
    @games = Game.all

    render json: @games
  end

  # GET /games/1
  def show
    json = @game.as_json
    json[:score] = @game.score if @game.score?

    render json: json
  end

  # POST /games
  def create
    @game = Game.create!
    render json: @game, status: :created, location: @game
  end

  # DELETE /games/1
  def destroy
    @game.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:id])
  end
end
