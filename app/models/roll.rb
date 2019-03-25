# frozen_string_literal: true

# Represents one throw of the bowling ball.
class Roll < ApplicationRecord
  belongs_to :frame

  validates :score, inclusion: { in: (0..10) }
  validates :number, inclusion: { in: (1..3) }
  validate :frame_is_ready

  def frame_is_ready
    return if frame.ready_for_new_rolls?

    errors.add(:frame, "Frame isn't ready for new rolls")
  end
end
