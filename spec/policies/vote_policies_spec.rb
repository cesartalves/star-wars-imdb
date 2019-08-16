require "rails_helper"

RSpec.describe VotePolicies do 
 
    it 'only allows valid vote_types' do
        expect(VotePolicies.valid_type?(VotePolicies::UPVOTE)).to eq true
        expect(VotePolicies.valid_type?(VotePolicies::DOWNVOTE)).to eq true
        expect(VotePolicies.valid_type?('anything_else')).to eq false
    end
end