# frozen_string_literal: true

require 'spec_helper'
require 'bowling'

RSpec.describe Bowling do
  # A simple Duck-type Frame which responds to #rolls,
  # returning an array of two or three integers representing
  # the number of pins hit on the rolls.
  Frame = Struct.new('Frame', :rolls, keyword_init: true)

  describe '#score' do
    it 'returns 0 for all gutter-balls' do
      all_gutterballs = []
      10.times { all_gutterballs << Frame.new(rolls: [0, 0]) }

      expect(Bowling.score(for_frames: all_gutterballs)).to eq(0)
    end
  end
end
