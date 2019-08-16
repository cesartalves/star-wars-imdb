require "rails_helper"

RSpec.describe MoviesController, type: :controller do
  
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
        
    end
end