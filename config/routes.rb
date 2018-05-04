Rails.application.routes.draw do  
  devise_for :users

  resources :movies do
    resources :reviews, except: [:show, :index]
    member do
	    put "like", to: "movies#upvote"
	    put "dislike", to: "movies#downvote"
	    post :rate
	  end
  end

  root 'movies#index'
end