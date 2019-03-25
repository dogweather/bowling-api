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
      game_id: params.fetch(:game_id),
      number:  params.fetch(:frame_id)
    )

    @roll = Roll.new(
      frame_id: frame.id,
      score:    params.fetch(:score),
      number:   frame.next_roll_number
    )

    if @roll.save
      url = game_frame_roll_path(
        game_id:  params.fetch(:game_id),
        frame_id: params.fetch(:frame_id),
        id:       @roll.number
      )
      render json: @roll, status: :created, location: url
    else
      render json: @roll.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_roll
    num = params[:id]
    frame = Frame.find_by!(
      game_id: params.fetch(:game_id),
      number:  params.fetch(:frame_id)
    )

    @roll = Roll.find_by!(number: num, frame_id: frame.id)
  end
end
