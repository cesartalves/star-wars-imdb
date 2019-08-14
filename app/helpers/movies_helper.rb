module MoviesHelper

    def user_can_vote?(movie)
        vote_policy = UserVotePolicy.new

        !Vote.exists?(user: current_user, movie_id: movie['episode_id']) && vote_policy.has_votes_left?(current_user)
        
    end
end
