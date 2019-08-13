class AddMovieIdToVote < ActiveRecord::Migration[5.2]
  def change
    add_column :votes, :movie_id, :integer
  end
end
