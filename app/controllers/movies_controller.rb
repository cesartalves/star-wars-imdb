
class MoviesController < ApplicationController

    before_action :authenticate_user!

    def initialize
        super
        @user_vote_policy = UserVotePolicy.new
    end

    def index        
        @movies = MoviesFacade.movies 

        @remaining_votes = @user_vote_policy.remaining_votes current_user
       
    end

    def ranking
        @movies = MoviesFacade.movies_ranked
        @best_movies = @movies.first(MoviePolicies.number_of_best_movies_to_show)
    end   

    def details
        id = params[:id]

        @movie = MoviesFacade.movie id

        @movie["character_details"] = MoviesFacade.characters @movie
        @movie["planet_details"] = MoviesFacade.planets @movie

        # this is a good candidate for ajax, because the requests lock the server for too long
    end
  
end
