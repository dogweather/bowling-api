# frozen_string_literal: true

# The main resource / concept in the application. It's the
# root of the object hierarchy.
class Game < ApplicationRecord
  has_many :frames
end
