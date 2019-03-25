# frozen_string_literal: true

# Represents one throw of the bowling ball.
class Roll < ApplicationRecord
  belongs_to :frame

  validates :score, inclusion: { in: (1..10) }
end
