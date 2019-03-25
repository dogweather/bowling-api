# frozen_string_literal: true

# Ten-pin Bowling algorithms and logic
module Bowling
  module_function

  # @param for_frames [Array[#rolls]]
  # @return [Integer]
  def score(for_frames:)
    pins(for_frames) + bonuses(for_frames)
  end

  # Private

  # @return [Integer]
  def pins(frames)
    frames.map(&:rolls)
          .flatten
          .sum
  end

  def bonuses(frames)
    take_all_by_3(frames).map do |current, next_1, next_2|
      next_two_rolls = [next_1, next_2].compact
                                       .map(&:rolls)
                                       .flatten
                                       .slice(0, 2)
      if spare?(frame: current)
        next_two_rolls.first
      elsif strike?(frame: current)
        next_two_rolls.sum
      else
        0
      end
    end.sum
  end

  def spare?(frame:)
    frame.rolls.count == 2 && frame.rolls.sum == 10
  end

  def strike?(frame:)
    frame.rolls.count == 1 && frame.rolls.first == 10
  end

  # Return an array of arrays consisting of each element
  # paired with its successor or `nil` if it has none.
  #
  # @example
  #
  #   ['a', 'b', 'c'] => [['a', 'b', 'c'], ['b', 'c', nil], ['c', nil, nil]]
  #
  # @param ary [Array]
  # @return [Array[Array]]
  def take_all_by_3(ary)
    ary.map.with_index { |x, i| [x, ary[i + 1], ary[i + 2]] }
  end
end
