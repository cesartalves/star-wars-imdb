class VotingService

    def compute_vote(movie_id, vote_type, current_user)
        movie = Movie.where(id: movie_id).first_or_create
        
        Vote.create(vote_type: vote_type, movie_id: movie_id, user: current_user)
    end

end