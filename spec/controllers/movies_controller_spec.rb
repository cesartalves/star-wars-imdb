require "rails_helper"


RSpec.configure do |c|   
  c.infer_base_class_for_anonymous_controllers = true
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
            sign_in User.create(email: 'emai@valid', password: 'topsecret')
            get :index
            expect(response).to have_http_status(:success)
        end

        it "renders the index template" do
            sign_in User.create(email: 'emai@valid', password: 'topsecret')
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
            sign_in User.create(email: 'emai@valid', password: 'topsecret')
            get :ranking
            expect(response).to have_http_status(:success)
        end

        it "renders the ranking template" do
            sign_in User.create(email: 'emai@valid', password: 'topsecret')
            get :ranking
            expect(response).to render_template("movies/ranking")
        end
    end

    describe "GET details" do

        it "redirects to sign_in without user" do
            get :details, params: { id: 1 }
            expect(response).to have_http_status(:redirect)
            expect(response).to redirect_to('/users/sign_in')
        end

        it "succeeds with user", skip: "makes slow call to API" do
            sign_in User.create(email: 'emai@valid', password: 'topsecret')
            get :details, params: { id: 1 }
            expect(response).to have_http_status(:success)
        end

        context "with_mock_moveis_facade" do
            controller do       
                def initialize()
                    super
                    @user_vote_policy = UserVotePolicy.new
                    @movies_facade = Class.new do 
                        def movies() 
                            [ { 'episode_id' => 1 }]
                        end

                        def movies_ranked()
                            [ { 'episode_id' => 1 }]
                        end

                    end.new    
                end
            end

            it "renders the ranking template", skip: "makes slow call to API" do
                sign_in User.create(email: 'emai@valid', password: 'topsecret')
                get :details, params: { :id => 1 }
                expect(response).to render_template("movies/details")
            end
        end   
    end
end