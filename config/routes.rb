Rails.application.routes.draw do
  namespace :v1 do
    resources :trainers, param: :name do
      resources :battle_pets
    end
  end
end
