require 'net/http'
require 'json'

class MoviesController < ApplicationController

    before_action :authenticate_user!

    def index        
        @movies = get_movies_from_api_sorted('episode_id')

        @movies.each do |movie| 
            movie['canvote?'] = Vote.exists?(user: current_user, movie_id: movie['episode_id'])
        end

        @remaining_votes = get_user_remaining_votes
        @user_can_vote = user_can_vote?
    end

    def details
        id = params[:id]

        @movie = get_movie_from_api(id)

        @movie["character_details"] = get_characters @movie
        @movie["planet_details"] = get_planets @movie

        #this is a good candidate for ajax :3
    end

    def get_characters(movie)

        character_details = []

        movie["characters"].each do |detail_api_link|
            character_details.push(json_to_hash(detail_api_link))
        end

        return character_details
    end

    def json_to_hash(url)
        response = Net::HTTP.get(URI url)
        JSON.parse(response)
    end

    def get_planets(movie)

        planet_details = []
        movie["planets"].each do |detail_api_link|
            planet_details.push(json_to_hash(detail_api_link))
        end

        return planet_details
    end

    def ranking
        number_of_best_movies_to_show = 2

        @movies = get_movies_with_ranking_sorted
        @best_movies = @movies.first(number_of_best_movies_to_show)
    end

    def get_movie_from_api(id)
        response = Net::HTTP.get(URI "https://swapi.co/api/films/#{id.to_i}/?format=json")
        JSON.parse(response)
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
            movie['ranking'] = get_movie_ranking movie
        end

        movies.sort_by { |movie| movie[hash_field]} .reverse #according to benchmarks this is the fastest way

    end

    def get_movie_ranking(movie_hash)
        Vote.where(:vote_type => 'upvote', :movie_id => movie_hash['episode_id']).count -
        Vote.where(:vote_type => 'downvote', :movie_id => movie_hash['episode_id']).count
    end


    def get_user_remaining_votes
        2 - Vote.where(:user_id => current_user.id).count
    end

    def user_can_vote?
        get_user_remaining_votes > 0
    end
end
