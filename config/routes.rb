Rails.application.routes.draw do
  devise_for :users

  root 'expeditions#index'

  resources :expeditions, only: [:index, :create, :show, :edit, :update, :destroy] do
    resources :coordinates, only: [:create]
    resources :annotations, only: [:create, :destroy]
    get '/annotations/grab' => 'annotations#grab', as: :grab_annotation
  end


end
