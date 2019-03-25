# frozen_string_literal: true

class AddScoreToRoll < ActiveRecord::Migration[5.2]
  def change
    add_column :rolls, :score, :integer, null: false
  end
end
