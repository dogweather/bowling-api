# frozen_string_literal: true

# Represents one throw of the bowling ball.
class Roll < ApplicationRecord
  belongs_to :frame

  validates :score, inclusion: { in: (0..10) }
  validates :number, inclusion: { in: (1..3) }
end
