# frozen_string_literal: true

# Represents a frame of 10-pin bowling.
class Frame < ApplicationRecord
  belongs_to :game
  has_many :rolls, dependent: :destroy

  # @return [Integer] the number to assign to a new
  #         roll or 0 if there is none.
  def next_roll_number
    return 0 if finished?

    rolls.count + 1
  end

  def finished?
    if number == 10
      finished_for_frame_10?
    else
      finished_for_normal_frame?
    end
  end

  private

  def finished_for_normal_frame?
    rolls.count == 2
  end

  def finished_for_frame_10?
    return true if rolls.count == 3
    return false if rolls.count < 2

    # When there are two rolls already thrown in the 10th frame, it's
    # finished if a strike or spare was not thrown.
    rolls[0].score + rolls[1].score < 10
  end
end
