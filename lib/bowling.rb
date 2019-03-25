# frozen_string_literal: true

# Ten-pin Bowling algorithms and logic
module Bowling
  module_function

  def score(for_frames:)
    for_frames.map { |f| f.rolls.sum }.sum
  end
end
