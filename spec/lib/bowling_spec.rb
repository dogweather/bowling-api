# frozen_string_literal: true

require 'spec_helper'
require 'bowling'

RSpec.describe Bowling do
  # A simple mock Frame with a working #rolls.
  MockFrame = Struct.new('MockFrame', :throws, keyword_init: true) do
    def rolls
      throws.map.with_index { |t, index| Roll.new(score: t, number: index + 1) }
    end
  end

  describe '#score' do
    let(:spare) { MockFrame.new(throws: [1, 9]) }
    let(:strike) { MockFrame.new(throws: [10]) }

    it 'returns 0 for all gutter-balls' do
      all_gutterballs = Array.new(10, MockFrame.new(throws: [0, 0]))

      expect(Bowling.score(for_frames: all_gutterballs)).to eq(0)
    end

    it 'returns the sum of rolls (one pointer rolls)' do
      one_pointer_rolls = Array.new(10, MockFrame.new(throws: [1, 1]))

      expect(Bowling.score(for_frames: one_pointer_rolls)).to eq(20)
    end

    it 'handles a spare correctly' do
      frames = [spare] + Array.new(9, MockFrame.new(throws: [3, 4]))
      expect(Bowling.score(for_frames: frames)).to eq(76)
    end

    it 'handles a strike correctly' do
      frames = [strike] + Array.new(9, MockFrame.new(throws: [3, 4]))
      expect(Bowling.score(for_frames: frames)).to eq(80)
    end

    it 'returns 300 for a perfect game' do
      perfect_game = Array.new(9, strike) + [MockFrame.new(throws: [10, 10, 10])]
      expect(Bowling.score(for_frames: perfect_game)).to eq(300)
    end

    it 'correctly calculates all spares' do
      game = Array.new(9, MockFrame.new(throws: [9, 1])) +
             [MockFrame.new(throws: [9, 1, 9])]
      expect(Bowling.score(for_frames: game)).to eq(190)
    end

    it 'correctly handles a spare in the 9th frame' do
      game = [
        MockFrame.new(throws: [1, 2]),
        MockFrame.new(throws: [1, 2]),
        MockFrame.new(throws: [1, 2]),
        MockFrame.new(throws: [1, 2]),
        MockFrame.new(throws: [1, 2]),
        MockFrame.new(throws: [1, 2]),
        MockFrame.new(throws: [1, 2]),
        MockFrame.new(throws: [1, 2]),
        MockFrame.new(throws: [1, 9]),
        MockFrame.new(throws: [1, 2])
      ]
      expect(Bowling.score(for_frames: game)).to eq(38)
    end

    it 'correctly handles a strike in the 9th frame' do
      game = [
        MockFrame.new(throws: [1, 2]),
        MockFrame.new(throws: [1, 2]),
        MockFrame.new(throws: [1, 2]),
        MockFrame.new(throws: [1, 2]),
        MockFrame.new(throws: [1, 2]),
        MockFrame.new(throws: [1, 2]),
        MockFrame.new(throws: [1, 2]),
        MockFrame.new(throws: [1, 2]),
        MockFrame.new(throws: [10]),
        MockFrame.new(throws: [1, 2])
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
