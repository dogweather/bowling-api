# frozen_string_literal: true

# Ten-pin Bowling algorithms and logic
module Bowling
  module_function

  # @param for_frames [Array[#rolls]]
  # @return [Integer]
  def score(for_frames:)
    simple_points(for_frames) + bonuses(for_frames)
  end

  # Private

  # @return [Integer]
  def simple_points(frames)
    all_rolls(frames).sum
  end

  # @return [Integer]
  def bonuses(frames)
    take_all_by_3(frames).map do |current, next_1, next_2|
      next_two_rolls = all_rolls([next_1, next_2]).slice(0, 2)

      if spare?(frame: current)
        next_two_rolls.first
      elsif strike?(frame: current)
        next_two_rolls.sum
      else
        0
      end
    end.sum
  end

  # Be forgiving of nils in the input,
  # and return an array of the counts of
  # pins knocked down.
  #
  # @return [Array<Integer>]
  def all_rolls(frames)
    frames.compact
          .map(&:rolls)
          .flatten
  end

  def spare?(frame:)
    frame.rolls.count == 2 && frame.rolls.sum == 10
  end

  def strike?(frame:)
    frame.rolls.count == 1 && frame.rolls.first == 10
  end

  # Return an array of arrays consisting of each element
  # followed by its two successors or `nil` if none.
  #
  # @example
  #
  #   ['a', 'b', 'c'] => [['a', 'b', 'c'], ['b', 'c', nil], ['c', nil, nil]]
  #
  # @param ary [Array]
  # @return [Array<Array>]
  def take_all_by_3(ary)
    ary.map.with_index { |x, i| [x, ary[i + 1], ary[i + 2]] }
  end
end
