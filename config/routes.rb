Rails.application.routes.draw do
  resources :notes, only: [:create, :index, :show]
end

