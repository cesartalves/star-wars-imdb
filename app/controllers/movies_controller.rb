require 'net/http'
require 'json'

class MoviesController < ApplicationController

    before_action :authenticate_user!

    def index
        
        @movies = get_movies_from_api["results"]
    end

    def ranking
        @ranked_movies = [  ]
    end

    def get_movies_from_api
        movies_api_uri = URI 'https://swapi.co/api/films/?format=json'
        response = Net::HTTP.get(movies_api_uri)
        JSON.parse(response)
    end
end
