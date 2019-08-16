class Vote < ApplicationRecord
    belongs_to :user
    belongs_to :movie

    validates :movie_id, presence: true, numericality: { only_integer: true }
    validates :vote_type, presence: true
    validate :vote_type_valid

    def vote_type_valid
        if !VotePolicies.valid_type?(vote_type) 
            errors.add(:vote_type, 'Vote type must be downvote or upvote')
        end
    end
end
