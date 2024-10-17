# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[6.0]

  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.date :start_date, null: false
      t.date :end_date

      t.timestamps
    end
  end

end
