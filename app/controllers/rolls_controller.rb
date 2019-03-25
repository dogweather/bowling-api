# frozen_string_literal: true

class RollsController < ApplicationController
  before_action :set_roll, only: [:show]

  # GET /rolls
  def index
    @rolls = Roll.all

    render json: @rolls
  end

  # GET /rolls/1
  def show
    render json: @roll
  end

  # POST /rolls
  def create
    frame = Frame.find_by!(
      game_id: roll_params[:game_id],
      number:  roll_params[:frame_id]
    )

    @roll = Roll.new(frame_id: frame.id, score: roll_params[:score])

    if @roll.save
      render json: @roll, status: :created, location: @roll
    else
      render json: @roll.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_roll
    @roll = Roll.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def roll_params
    params.require(%i[frame_id game_id score])
          .permit(:frame_id, :game_id, :score)
  end
end
