class VotesController < ApplicationController

    before_action :authenticate_user!

    def vote
        
        movie_id = params[:movie_id]
        vote_type = params[:vote_type]

        movie = Movie.where(id: movie_id).first_or_create

        if Vote.create(vote_type: vote_type, movie_id: movie_id, user: current_user)
             flash[:notice] = "Voto computado!"
        else

        end

        redirect_to root_url
    end
end
