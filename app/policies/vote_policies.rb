class VotePolicies

    DOWNVOTE = "downvote".freeze
    UPVOTE = "upvote".freeze

    def self.valid_type?(vote_type)
        vote_type == DOWNVOTE || vote_type == UPVOTE
    end
end