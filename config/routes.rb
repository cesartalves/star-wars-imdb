Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "movies", to: "movies#index", as: :movies_index
  get "ranking", to: "movies#ranking", as: :movies_ranking
  get "ranking/:id", to: "movies#details"


  post "vote", to: "votes#vote"

  root to: "movies#index"

end
