require 'net/http'
require 'json'

class MoviesController < ApplicationController

    before_action :authenticate_user!

    def index        
        @movies = get_movies_from_api_sorted('episode_id')
        @remaining_votes = get_user_remaining_votes
    end

    def ranking
        @movies = get_movies_with_ranking_sorted
    end

    def get_movies_from_api
        movies_api_uri = URI 'https://swapi.co/api/films/?format=json'
        response = Net::HTTP.get(movies_api_uri)
        JSON.parse(response)
    end

    def get_movies_from_api_sorted(hash_field='episode_id')
        get_movies_from_api['results'].sort_by { |movie| movie[hash_field] }
    end

    def get_movies_with_ranking_sorted(hash_field='ranking')
        movies = get_movies_from_api['results']

        movies.each do |movie|
            movie['ranking'] = 
                Vote.where(:vote_type => 'upvote', :movie_id => movie['episode_id']).count -
                Vote.where(:vote_type => 'downvote', :movie_id => movie['episode_id']).count
        end

        movies.sort_by { |movie| movie[hash_field]} .reverse #according to benchmarks this is the fastest way

    end

    def get_user_remaining_votes
        2 - Vote.where(:user_id => current_user.id).count
    end
end
