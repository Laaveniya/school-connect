class CreateEnrollments < ActiveRecord::Migration[7.0]
  def change
    create_table :enrollments do |t|
      t.references :course_batch, null: false, foreign_key: true
      t.references :student, foreign_key: { to_table: :users }, null: false
      t.references :approver, foreign_key: { to_table: :users }
      t.integer :status

      t.timestamps
    end
  end
end
