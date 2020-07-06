require "rails_helper"

RSpec.describe VotesController, type: :controller do

    describe "POST vote" do

        it "fails if user is not logged" do
            post :vote,  :params => { }
            expect(response).to redirect_to('/users/sign_in')
        end

        it "adds error flash if no params are present" do

            sign_in User.create(email: 'any@ema.com', password: 'topsecret')
            post :vote,  :params => { }
            expect(response).to redirect_to(:root)
            expect(flash[:error]).to be_present
            expect(flash[:error]).to match("Houve algum erro computando seu voto. :(")
        end

        it "adds error flash if vote type is invalid" do

            sign_in User.create(email: 'any@ema.com', password: 'topsecret')
            post :vote,  :params => { :movie_id => 1, :vote_type => "invalid type" }
            expect(response).to redirect_to(:root)
            expect(flash[:error]).to be_present
            expect(flash[:error]).to match("Houve algum erro computando seu voto. :(")
        end

        it "adds error flash if user already voted on given movie" do 

            user = User.create(email: 'someuser@ema.com', password: 'topsecret')

            movie = Movie.create(id: 1)

            sign_in user
            Vote.create!(user: user, movie: movie, vote_type: "upvote")

            post :vote,  :params => { :movie_id => 1, :vote_type => "upvote" }
            expect(response).to redirect_to(:root)
            expect(flash[:error]).to be_present
            expect(flash[:error]).to match("Houve algum erro computando seu voto. :(")

        end 

        it "adds error flash if user already voted too much" do 
  
            user = User.create(email: 'someuser@ema.com', password: 'topsecret')

            sign_in user
            Movie.create(id: 1)
            Movie.create(id: 2)
            Movie.create(id: 3)

            Vote.create!(user: user, movie_id: 1, vote_type: "upvote")
            Vote.create!(user: user, movie_id: 2, vote_type: "upvote")

            post :vote,  :params => { :movie_id => 3, :vote_type => "upvote" }
            expect(response).to redirect_to(:root)
            expect(flash[:error]).to be_present
            expect(flash[:error]).to match("Houve algum erro computando seu voto. :(")

        end      

        it "succeeds if all requirements are met" do
            user = User.create(email: 'someuser@ema.com', password: 'topsecret')

            sign_in user
            Movie.create(id: 1)

            post :vote,  :params => { :movie_id => 1, :vote_type => "upvote" }
            expect(response).to redirect_to(:root)
            expect(flash[:notice]).to be_present
            expect(flash[:notice]).to match(/Voto computado!/)
        end

        context "regarding authentication" do 
            
            before {  ActionController::Base.allow_forgery_protection = true}
            after {  ActionController::Base.allow_forgery_protection = false }

            it "shows flash error on invalid authentication token" do
            
                user = User.create(email: 'someuser@ema.com', password: 'topsecret')

                sign_in user
                Movie.create(id: 1)

                post :vote,  :params => { :movie_id => 1, :vote_type => "upvote" }
                expect(response).to redirect_to(:root)
                expect(flash[:error]).to be_present
                expect(flash[:error]).to match(/Falha em checar autenticidade do voto. Tente novamente./)

            end
        end

    end
end