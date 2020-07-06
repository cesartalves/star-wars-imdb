class VotingService

    class VotesExceededError < StandardError; end
    class AlreadyVotedOnMovieError < StandardError; end

    def initialize(user_voting_policy)
        @user_voting_policy = user_voting_policy
    end

    def compute_vote(movie_id, vote_type, current_user)
        movie = Movie.where(id: movie_id).first_or_create!
        
        begin
            raise VotesExceededError if !@user_voting_policy.has_votes_left?(current_user)
            raise AlreadyVotedOnMovieError if Vote.exists?(user: current_user, movie_id: movie_id)
            
            Vote.create!(vote_type: vote_type, movie_id: movie_id, user: current_user)

            return true
        rescue VotesExceededError, AlreadyVotedOnMovieError, ActiveRecord::RecordInvalid
            return false
        end
    end

end