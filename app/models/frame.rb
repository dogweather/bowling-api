# frozen_string_literal: true

# Represents a frame of 10-pin bowling.
class Frame < ApplicationRecord
  belongs_to :game
  has_many :rolls, dependent: :destroy

  # @return [Integer] the number to assign to a new
  #         roll.
  def next_roll_number
    limit = number == 10 ? 3 : 2
    raise "Frame #{number} already has #{limit} rolls" if rolls.count == limit

    rolls.count + 1
  end
end
