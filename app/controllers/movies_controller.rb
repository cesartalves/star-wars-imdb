
class MoviesController < ApplicationController

    before_action :authenticate_user!

    attr_accessor :movies_facade

    def initialize
        super
        @user_vote_policy = UserVotePolicy.new
        @movies_facade = MoviesFacade.new
    end

    def index        
        @movies = @movies_facade.movies 

        @remaining_votes = @user_vote_policy.remaining_votes current_user
       
    end

    def ranking
        @movies = @movies_facade.movies_ranked
        @best_movies = @movies.first(MoviePolicies.number_of_best_movies_to_show)
    end   

    def details
        episode_id = params[:episode]

        @movie = @movies_facade.movie episode_id

        @movie["character_details"] = @movies_facade.characters @movie
        @movie["planet_details"] = @movies_facade.planets @movie

        # this is a good candidate for ajax, because the requests lock the server for too long
    end
  
end
