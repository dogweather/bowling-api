# frozen_string_literal: true

# Ten-pin Bowling algorithms and logic
module Bowling
  module_function

  def score(for_frames:)
    simple_sum(for_frames) + bonuses(for_frames)
  end

  # Private

  def simple_sum(frames)
    frames.map { |f| f.rolls.sum }.sum
  end

  def bonuses(frames)
    take_all_by_2(frames).map do |tuple|
      curr_frame = tuple.first
      next_frame = tuple.last

      if spare?(frame: curr_frame)
        next_frame.rolls.first
      else
        0
      end
    end.sum
  end

  def spare?(frame:)
    frame.rolls.count == 2 && frame.rolls.sum == 10
  end

  # Return an array of arrays consisting of each element
  # paired with its successor or `nil` if it has none.
  #
  # @example
  #
  #   [1, 2, 3, 4] => [[1, 2], [2, 3], [3, 4], [4, nil]]
  #
  # @param ary [Array]
  # @return [Array[Array]]
  def take_all_by_2(ary)
    ary.map.with_index { |x, i| [x, ary[i + 1]] }
  end
end
