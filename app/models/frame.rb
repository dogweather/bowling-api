# frozen_string_literal: true

# Represents a frame of 10-pin bowling.
class Frame < ApplicationRecord
  belongs_to :game
end
