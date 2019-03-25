# frozen_string_literal: true

class Roll < ApplicationRecord
  belongs_to :frame

  validates :score, inclusion: { in: (1..10) }
end
