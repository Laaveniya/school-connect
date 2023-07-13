class AddCreatorToSchools < ActiveRecord::Migration[7.0]
  def change
    add_reference :schools, :creator, foreign_key: { to_table: :users }
  end
end
