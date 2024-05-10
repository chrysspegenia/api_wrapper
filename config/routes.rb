Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :icons
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  resources :memes, except: :show
  get 'memes/generate_meme'

  resources :pokemon, only: :show
  get 'pokemon/pokedex/:id', to: 'pokemon#pokedex', as: 'pokedex'
  get 'pokemon/typedex/:id', to: 'pokemon#typedex', as: 'typedex'
  get 'pokemon/show_move/:id', to: 'pokemon#show_move', as: 'show_move'

end
