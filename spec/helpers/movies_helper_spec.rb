require "rails_helper"


describe MoviesHelper do

    let(:current_user) { User.create(email: 'any@email', password: 'topsecret') }

    it "user can vote if no votes where performed" do
        user_can_vote?({ 'episode_id' => 1}).should == true
    end

    it "user cannot vote if already voted on movie" do
        movie = Movie.create(id: 1)
        Vote.create(user: current_user, movie: movie, vote_type: 'upvote')

        expect(user_can_vote?({ 'episode_id' => 1})).to eq false

    end

    it "user cannot vote if already voted too much" do
        movie = Movie.create(id: 1)
        Vote.create(user: current_user, movie: movie, vote_type: 'upvote')

        movie = Movie.create(id: 2)
        Vote.create(user: current_user, movie: movie, vote_type: 'upvote')

        expect(user_can_vote?({ 'episode_id' => 3})).to eq false

    end
end