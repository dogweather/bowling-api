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
  end
end
