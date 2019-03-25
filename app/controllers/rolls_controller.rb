class RollsController < ApplicationController
  before_action :set_roll, only: [:show, :update, :destroy]

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
    @roll = Roll.new(roll_params)

    if @roll.save
      render json: @roll, status: :created, location: @roll
    else
      render json: @roll.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rolls/1
  def update
    if @roll.update(roll_params)
      render json: @roll
    else
      render json: @roll.errors, status: :unprocessable_entity
    end
  end

  # DELETE /rolls/1
  def destroy
    @roll.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_roll
      @roll = Roll.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def roll_params
      params.require(:roll).permit(:number, :frame_id)
    end
end
