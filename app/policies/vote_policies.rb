class VotePolicies

    def self.valid_type?(vote_type)
        vote_type == "downvote" || vote_type == "upvote"
    end
end