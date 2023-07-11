class EnableSearchkick < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'pg_search'
  end
end
