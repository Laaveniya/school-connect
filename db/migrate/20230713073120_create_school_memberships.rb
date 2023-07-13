class CreateSchoolMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :school_memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :school, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
