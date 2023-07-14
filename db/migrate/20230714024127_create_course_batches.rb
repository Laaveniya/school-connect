class CreateCourseBatches < ActiveRecord::Migration[7.0]
  def change
    create_table :course_batches do |t|
      t.string :name
      t.integer :max_enrollment_count
      t.date :start_date
      t.date :end_date
      t.belongs_to :course
      t.belongs_to :creator, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end
  end
end
