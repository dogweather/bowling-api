# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game, type: :model do
  context('when new') do
    it 'has ten frames' do
      expect(Game.create.frames.count).to eq(10)
    end
  end
end
