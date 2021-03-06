# frozen_string_literal: true

require 'bowling'

# The main resource / concept in the application. It's the
# root of the object hierarchy.
class Game < ApplicationRecord
  has_many :frames, dependent: :destroy

  after_save do |game|
    (1..10).each { |n| Frame.create!(number: n, game: game) }
  end


  def score?
    frames.all?(&:finished?)
  end

  def score
    Bowling.score(for_frames: frames.to_a)
  end
end
