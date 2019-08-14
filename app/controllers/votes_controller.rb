class VotesController < ApplicationController

    before_action :authenticate_user!

    def vote
        movie_id = params[:movie_id]
        vote_type = params[:vote_type]
      
        if compute_vote(movie_id, vote_type)
            flash[:notice] = "Voto computado!"
        else
            flash[:error] = "Houve algum erro computando seu voto :("
        end

        redirect_to root_url
    end

    def compute_vote(movie_id, vote_type)
        VotingService.new.compute_vote movie_id, vote_type, current_user
    end
end
