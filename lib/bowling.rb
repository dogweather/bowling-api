# frozen_string_literal: true

# Ten-pin Bowling algorithms and logic
module Bowling
  module_function

  # The public function to compute the score of
  # a ten-pin bowling game.
  #
  # Add the basic score of 1 point per pin knocked down
  # to the additional points given for strikes and spares.
  #
  # @param for_frames [Array<#rolls>] An Array of objects
  #        which respond to #rolls, which returns an Array of
  #        integers representing how many pins were knocked
  #        down by a roll.
  # @return [Integer]
  def score(for_frames:)
    simple_points(for_frames) + bonuses(for_frames)
  end

  # Private

  # The total number of pins knocked down in the game.
  # Each pin equals one point.
  #
  # @return [Integer]
  def simple_points(frames)
    all_rolls(frames).sum
  end

  # The total additional points given due to rolling
  # a spare or strike.
  #
  # Algorithm: Iterate through each frame, calculating
  # the spare/strike bonus due. Do this by considering three
  # frames at a time: the current frame plus the next two
  # which follow. The player may have rolled many strikes, and
  # so, up to two following frames may need to be consulted.
  #
  # @return [Integer]
  def bonuses(frames)
    frame_tuples = take_all_by_3(frames)
    frame_tuples.pop # No bonus for the 10th frame

    frame_tuples.map { |t| bonus(t) }
                .sum
  end

  def bonus(frame_tuple)
    current, next1, next2 = frame_tuple
    next_two_rolls = all_rolls([next1, next2]).slice(0, 2)

    if spare?(frame: current)
      next_two_rolls.first
    elsif strike?(frame: current)
      next_two_rolls.sum
    else
      0
    end
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
