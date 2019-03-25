# frozen_string_literal: true

require 'spec_helper'
require 'bowling'

RSpec.describe Bowling do
  # A simple Duck-type Frame which responds to #rolls,
  # returning an array of two or three integers representing
  # the number of pins hit on the rolls.
  MockFrame = Struct.new('MockFrame', :rolls, keyword_init: true)

  describe '#score' do
    let(:spare) { MockFrame.new(rolls: [1, 9]) }
    let(:strike) { MockFrame.new(rolls: [10]) }

    it 'returns 0 for all gutter-balls' do
      all_gutterballs = Array.new(10, MockFrame.new(rolls: [0, 0]))

      expect(Bowling.score(for_frames: all_gutterballs)).to eq(0)
    end

    it 'returns the sum of rolls (one pointer rolls)' do
      one_pointer_rolls = Array.new(10, MockFrame.new(rolls: [1, 1]))

      expect(Bowling.score(for_frames: one_pointer_rolls)).to eq(20)
    end

    it 'handles a spare correctly' do
      frames = [spare] + Array.new(9, MockFrame.new(rolls: [3, 4]))
      expect(Bowling.score(for_frames: frames)).to eq(76)
    end

    it 'handles a strike correctly' do
      frames = [strike] + Array.new(9, MockFrame.new(rolls: [3, 4]))
      expect(Bowling.score(for_frames: frames)).to eq(80)
    end

    it 'returns 300 for a perfect game' do
      perfect_game = Array.new(9, strike) + [MockFrame.new(rolls: [10, 10, 10])]
      expect(Bowling.score(for_frames: perfect_game)).to eq(300)
    end

    it 'correctly calculates all spares' do
      game = Array.new(9, MockFrame.new(rolls: [9, 1])) +
             [MockFrame.new(rolls: [9, 1, 9])]
      expect(Bowling.score(for_frames: game)).to eq(190)
    end

    it 'correctly handles a spare in the 9th frame' do
      game = [
        MockFrame.new(rolls: [1, 2]),
        MockFrame.new(rolls: [1, 2]),
        MockFrame.new(rolls: [1, 2]),
        MockFrame.new(rolls: [1, 2]),
        MockFrame.new(rolls: [1, 2]),
        MockFrame.new(rolls: [1, 2]),
        MockFrame.new(rolls: [1, 2]),
        MockFrame.new(rolls: [1, 2]),
        MockFrame.new(rolls: [1, 9]),
        MockFrame.new(rolls: [1, 2])
      ]
      expect(Bowling.score(for_frames: game)).to eq(38)
    end

    it 'correctly handles a strike in the 9th frame' do
      game = [
        MockFrame.new(rolls: [1, 2]),
        MockFrame.new(rolls: [1, 2]),
        MockFrame.new(rolls: [1, 2]),
        MockFrame.new(rolls: [1, 2]),
        MockFrame.new(rolls: [1, 2]),
        MockFrame.new(rolls: [1, 2]),
        MockFrame.new(rolls: [1, 2]),
        MockFrame.new(rolls: [1, 2]),
        MockFrame.new(rolls: [10]),
        MockFrame.new(rolls: [1, 2])
      ]
      expect(Bowling.score(for_frames: game)).to eq(40)
    end
  end

  describe '#take_all_by_3' do
    it 'produces a 3-tuple for every element, including nils if needed' do
      input = [1, 2, 3, 4, 5]
      expected = [[1, 2, 3], [2, 3, 4], [3, 4, 5], [4, 5, nil], [5, nil, nil]]
      expect(Bowling.take_all_by_3(input)).to eq(expected)
    end
  end
end
