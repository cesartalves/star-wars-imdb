class UserVotePolicy

    def initialize(votes_per_user = 2)
        @votes_per_user = votes_per_user
    end

    def remaining_votes(user)
        @votes_per_user - Vote.where(user: user).count
    end

    def has_votes_left?(user)
        remaining_votes(user) > 0
    end

end