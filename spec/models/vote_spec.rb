require "rails_helper"

RSpec.describe Vote, :type => :model do
    context 'creation fails if Vote' do
        it 'has a nil user' do 
            expect(
                Vote.create(vote_type: 'upvote', movie_id: 1, user_id: nil).valid?
            ).to eq false
        end
        it 'has a nil movie' do 
            expect(
                Vote.create(vote_type: 'upvote', movie_id: nil, user_id: 1).valid?
            ).to eq false
        end
        it 'has a nil vote type' do 
            expect(
                Vote.create(vote_type: nil, movie_id: 1, user_id: 1).valid?
            ).to eq false
        end
        it 'has an invalid vote type' do 
            expect(
                Vote.create(vote_type: 'auyegaugeygasgyiyaeaea', movie_id: 1, user_id: 1).errors.messages
            ).to include :vote_type => ["Vote type must be downvote or upvote"]
        end
        
    end

end