# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game, type: :model do
  fixtures(:games)

  context('when new') do
    it 'has ten frames' do
      expect(games(:new_game).frames.count).to eq(10)
    end
  end
end
