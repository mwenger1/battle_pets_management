Rails.application.routes.draw do
  namespace :v1 do
    resources :battle_pets, only: [:show], controller: "individual_battle_pets"

    resources :trainers, param: :name do
      resources :battle_pets
    end
  end
end
