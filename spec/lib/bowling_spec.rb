# frozen_string_literal: true

require 'spec_helper'
require 'bowling'

RSpec.describe Bowling do
  # A simple Duck-type Frame which responds to #rolls,
  # returning an array of two or three integers representing
  # the number of pins hit on the rolls.
  Frame = Struct.new('Frame', :rolls, keyword_init: true)

  describe '#score' do
    let(:spare) { Frame.new(rolls: [1, 9]) }
    let(:strike) { Frame.new(rolls: [10]) }

    it 'returns 0 for all gutter-balls' do
      all_gutterballs = Array.new(10, Frame.new(rolls: [0, 0]))

      expect(Bowling.score(for_frames: all_gutterballs)).to eq(0)
    end

    it 'returns the sum of rolls (one pointer rolls)' do
      one_pointer_rolls = Array.new(10, Frame.new(rolls: [1, 1]))

      expect(Bowling.score(for_frames: one_pointer_rolls)).to eq(20)
    end

    it 'handles a spare correctly' do
      frames = [spare] + Array.new(9, Frame.new(rolls: [3, 4]))
      expect(Bowling.score(for_frames: frames)).to eq(76)
    end

    it 'handles a strike correctly' do
      frames = [strike] + Array.new(9, Frame.new(rolls: [3, 4]))
      expect(Bowling.score(for_frames: frames)).to eq(80)
    end

    it 'returns 300 for a perfect game' do
      perfect_game = Array.new(9, strike) + [Frame.new(rolls: [10, 10, 10])]
      expect(Bowling.score(for_frames: perfect_game)).to eq(300)
    end

    it 'correctly calculates all spares' do
      game = Array.new(9, Frame.new(rolls: [9, 1])) +
             [Frame.new(rolls: [9, 1, 9])]
      expect(Bowling.score(for_frames: game)).to eq(190)
    end

    it 'correctly handles a spare in the 9th frame' do
      game = [
        Frame.new(rolls: [1, 2]),
        Frame.new(rolls: [1, 2]),
        Frame.new(rolls: [1, 2]),
        Frame.new(rolls: [1, 2]),
        Frame.new(rolls: [1, 2]),
        Frame.new(rolls: [1, 2]),
        Frame.new(rolls: [1, 2]),
        Frame.new(rolls: [1, 2]),
        Frame.new(rolls: [1, 9]),
        Frame.new(rolls: [1, 2])
      ]
      expect(Bowling.score(for_frames: game)).to eq(38)
    end

    it 'correctly handles a strike in the 9th frame' do
      game = [
        Frame.new(rolls: [1, 2]),
        Frame.new(rolls: [1, 2]),
        Frame.new(rolls: [1, 2]),
        Frame.new(rolls: [1, 2]),
        Frame.new(rolls: [1, 2]),
        Frame.new(rolls: [1, 2]),
        Frame.new(rolls: [1, 2]),
        Frame.new(rolls: [1, 2]),
        Frame.new(rolls: [10]),
        Frame.new(rolls: [1, 2])
      ]
      expect(Bowling.score(for_frames: game)).to eq(40)
    end
  end
end
