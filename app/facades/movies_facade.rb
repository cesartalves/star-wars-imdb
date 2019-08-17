require 'net/http'
require 'json'

class MoviesFacade

    def movies(sorting_field='episode_id')
        movies = get_movies_from_api

        movies.sort_by { |movie| movie[sorting_field] }
    end

    def movies_ranked

        movies = get_movies_from_api

        movies.each do |movie|
            movie['ranking'] = get_movie_ranking movie
        end

        movies.sort_by { |movie| movie['ranking']} .reverse #according to benchmarks this is the fastest way
    end

    def get_movies_from_api
        movies_api_uri = URI 'https://swapi.co/api/films/?format=json'

        response = Net::HTTP.get(movies_api_uri)
        movies = JSON.parse(response)['results']
    end


    def get_movie_ranking(movie)
        Vote.where(:vote_type => VotePolicies::UPVOTE, :movie_id => movie['episode_id']).count -
        Vote.where(:vote_type => VotePolicies::DOWNVOTE, :movie_id => movie['episode_id']).count
    end

    def movie(id)
        response = Net::HTTP.get(URI "https://swapi.co/api/films/#{id.to_i}/?format=json")
        JSON.parse(response)
    end

    def characters(movie)
        character_details = []

        movie["characters"].each do |detail_api_link|
            character_details.push(json_to_hash(detail_api_link))
        end

        return character_details
    end

    def planets(movie)
        planet_details = []
        movie["planets"].each do |detail_api_link|
            planet_details.push(json_to_hash(detail_api_link))
        end

        return planet_details
    end

    def json_to_hash(url)
        response = Net::HTTP.get(URI url)
        JSON.parse(response)
    end

    # private_class_method :json_to_hash

end