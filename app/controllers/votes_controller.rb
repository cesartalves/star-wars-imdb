class VotesController < ApplicationController

    before_action :authenticate_user!

    rescue_from ActionController::InvalidAuthenticityToken, with: :handle_csrf_error

    def initialize
        super
        @user_vote_policy = UserVotePolicy.new
    end

    def vote
        movie_id = params[:movie_id]
        vote_type = params[:vote_type]
      
        
        if compute_vote(movie_id, vote_type)
            flash[:notice] = "Voto computado!"
        else
            flash[:error] = "Houve algum erro computando seu voto. :("
        end

        redirect_to root_url
    end

    def handle_csrf_error
        flash[:error] = "Falha em checar autenticidade do voto. Tente novamente."
        redirect_to root_url
    end

    def compute_vote(movie_id, vote_type)
        VotingService.new(@user_vote_policy).compute_vote movie_id, vote_type, current_user
    end
end
