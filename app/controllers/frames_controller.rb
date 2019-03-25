# frozen_string_literal: true

# Handle API requests for the Frame resource.
class FramesController < ApplicationController
  before_action :set_frame, only: %i[show]

  # GET /frames
  def index
    @frames = Frame.all

    render json: @frames
  end

  # GET /frames/1
  def show
    render json: @frame
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_frame
    @frame = Frame.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def frame_params
    params.require(:frame).permit(:number, :game_id)
  end
end
