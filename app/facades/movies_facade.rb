require 'net/http'
require 'json'
require 'open-uri'

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
        json_to_hash('https://swapi.dev/api/films/?format=json')["results"]
    end


    def get_movie_ranking(movie)
        Vote.where(:vote_type => VotePolicies::UPVOTE, :movie_id => movie['episode_id']).count -
        Vote.where(:vote_type => VotePolicies::DOWNVOTE, :movie_id => movie['episode_id']).count
    end

    def movie(episode_id)

        api_id = map_to_api episode_id

        json_to_hash("https://swapi.dev/api/films/#{api_id}/?format=json")
    end

    def map_to_api(episode_id)

        {
            "4" => 1 ,
            "5" => 2 ,
            "6" => 3 ,
            "1" => 4 ,
            "2" => 5 ,
            "3" => 6 ,
            "7" => 7
        } [episode_id]
    end

    def characters(movie); get_from movie, "characters"; end
    def planets(movie); get_from movie, "planets"; end

    def get_from(movie, hash_name)
        array = []
        movie[hash_name].each do |detail_api_link|
            array.push(json_to_hash(detail_api_link))
        end
        return array
    end

    def json_to_hash(url)
        response = open(url).read
        JSON.parse(response)
    end

end