Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "movies", to: "movies#index", as: :movies_index

  root to: "movies#index"

end
