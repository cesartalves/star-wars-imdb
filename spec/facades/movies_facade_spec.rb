require "rails_helper"

RSpec.describe MoviesFacade  do

    it "has correct mapping for episode_id and id on api" do

        expect(MoviesFacade.new.map_to_api "4").to eq 1
        expect(MoviesFacade.new.map_to_api "5").to eq 2
        expect(MoviesFacade.new.map_to_api "6").to eq 3
        expect(MoviesFacade.new.map_to_api "1").to eq 4
        expect(MoviesFacade.new.map_to_api "2").to eq 5
        expect(MoviesFacade.new.map_to_api "3").to eq 6
        expect(MoviesFacade.new.map_to_api "7").to eq 7
        expect(MoviesFacade.new.map_to_api 3).to eq nil

    end

end