Rails.application.routes.draw do
  namespace :v1 do
    resources :trainers, param: :name
  end
end
