# frozen_string_literal: true

class CreateRolls < ActiveRecord::Migration[5.2]
  def change
    create_table :rolls do |t|
      t.integer :number, null: false
      t.references :frame, foreign_key: true, null: false

      t.timestamps
    end
  end
end
