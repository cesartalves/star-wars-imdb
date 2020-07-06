require "rails_helper"


RSpec.configure do |c|   
  c.infer_base_class_for_anonymous_controllers = false
end

RSpec.describe MoviesController, type: :controller do

    it "creates anonymous controller derived from the namespace" do
        expect(controller).to be_a_kind_of(MoviesController)
    end

    describe "GET index" do
        it "redirects to sign_in without user" do
            get :index
            expect(response).to have_http_status(:redirect)
            expect(response).to redirect_to('/users/sign_in')
        end

        it "succeeds with user" do
            sign_in User.create(email: 'emai@valepisode', password: 'topsecret')
            get :index
            expect(response).to have_http_status(:success)
        end

        it "renders the index template" do
            sign_in User.create(email: 'emai@valepisode', password: 'topsecret')
            get :index
            expect(response).to render_template("movies/index")
        end
    end
    
    describe "GET ranking" do

        it "redirects to sign_in without user" do
            get :ranking
            expect(response).to have_http_status(:redirect)
            expect(response).to redirect_to('/users/sign_in')
        end

        it "succeeds with user" do
            sign_in User.create(email: 'emai@valepisode', password: 'topsecret')
            get :ranking
            expect(response).to have_http_status(:success)
        end

        it "renders the ranking template" do
            sign_in User.create(email: 'emai@valepisode', password: 'topsecret')
            get :ranking
            expect(response).to render_template("movies/ranking")
        end
    end

    describe "GET details" do

        it "redirects to sign_in without user" do
            get :details, params: { episode: 1 }
            expect(response).to have_http_status(:redirect)
            expect(response).to redirect_to('/users/sign_in')
        end

        it "succeeds with user", speed: "slow" do
            sign_in User.create(email: 'emai@valepisode', password: 'topsecret')
            get :details, params: { episode: 1 }
            expect(response).to have_http_status(:success)
        end

        it "renders the details template", speed: "slow" do
                sign_in User.create(email: 'emai@valepisode', password: 'topsecret')
                get :details, params: { :episode => 1 }

                expect(response).to have_http_status(:success)
                expect(response).to render_template("movies/details")
        end

        context "with render_views" do
            render_views

            it "renders the details template correctly", speed: "slow" do
                sign_in User.create(email: 'emai@valepisode', password: 'topsecret')

                expect(controller).to respond_to(:details)

                get :details, params: { episode: 1 }
                
                expect(response).to have_http_status(:success)
                expect(response).to render_template("movies/details")

                expect(response.body).to include("The Phantom Menace")
                expect(response.body).to include("Diretor: George Lucas")
                expect(response.body).to include("Lançamento: 1999-05-19")
            end
        end   
    end
end