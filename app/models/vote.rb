class Vote < ApplicationRecord
    belongs_to :user
    belongs_to :movie

    validates :movie_id, presence: true, numericality: { only_integer: true }
    validates :vote_type, presence: true, if: :vote_type_valid?

    def vote_type_valid?
        vote_type == "downvote" || vote_type == "upvote"
    end
end
