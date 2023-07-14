class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.date :start_date
      t.date :end_date
      t.integer :status, default: 0, null: false
      t.references :school, null: false, foreign_key: true

      t.timestamps
    end
  end
end
