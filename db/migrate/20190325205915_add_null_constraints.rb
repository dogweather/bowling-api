# frozen_string_literal: true

class AddNullConstraints < ActiveRecord::Migration[5.2]
  def change
    change_column_null :frames, :number, false
    change_column_null :frames, :game_id, false
  end
end
