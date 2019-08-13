class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies, {:primary_key => :id, id: false} do |t|
      t.integer :id
      t.timestamps
    end
  end
end
