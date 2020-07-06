require 'net/http'
require 'json'
require 'open-uri'

class MoviesFacade

    def self.movies(sorting_field='episode_id')
        movies = get_movies_from_api

        movies.sort_by { |movie| movie[sorting_field] }
    end

    def self.movies_ranked

        movies = get_movies_from_api

        movies.each do |movie|
            movie['ranking'] = get_movie_ranking movie
        end

        movies.sort_by { |movie| movie['ranking']} .reverse #according to benchmarks this is the fastest way
    end

    def self.get_movies_from_api
        movies_api_uri = URI 'https://swapi.dev/api/films/?format=json'

        response = Net::HTTP.get(movies_api_uri)
        movies = JSON.parse(response)['results']
    end

    private_class_method :get_movies_from_api

    def self.get_movie_ranking(movie)
        Vote.where(:vote_type => 'upvote', :movie_id => movie['episode_id']).count -
        Vote.where(:vote_type => 'downvote', :movie_id => movie['episode_id']).count
    end

    def self.movie(id)
        response = Net::HTTP.get(URI "https://swapi.dev/api/films/#{id.to_i}/?format=json")
        JSON.parse(response)
    end

    def self.characters(movie)
        character_details = []

        movie["characters"].each do |detail_api_link|
            character_details.push(json_to_hash(detail_api_link))
        end

        return character_details
    end

    def self.planets(movie)
        planet_details = []
        movie["planets"].each do |detail_api_link|
            planet_details.push(json_to_hash(detail_api_link))
        end

        return planet_details
    end

    def self.json_to_hash(url)
        response = open(url).read
        JSON.parse(response)
    end

    private_class_method :json_to_hash

end