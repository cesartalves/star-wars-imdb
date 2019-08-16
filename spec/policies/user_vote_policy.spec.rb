require "rails_helper"

RSpec.describe UserVotePolicy do 
 
    it 'works' do

        policy = UserVotePolicy.new(2)

        user = User.create(email: 'any@email.com', password: 'secret1')

        expect(policy.remaining_votes(user)).to eq 2

        Vote.create(user: user, movie_id: 1, vote_type: 'upvote')

        expect(policy.remaining_votes(user)).to eq 1

        Vote.create(user: user, movie_id: 3, vote_type: 'upvote')

        expect(policy.remaining_votes(user)).to eq 0

        expect(policy.has_votes_left?(user)).to eq false

    end
end