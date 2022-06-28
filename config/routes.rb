# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get 'user/:id', to: 'users/registrations#detail'
    get 'signup', to: 'users/registrations#new'
    get 'login', to: 'users/sessions#new'
    get 'logout', to: 'users/sessions#destroy'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome_pages#top'
  resources :graduation_albums do
    resources :menbers, only: %i[show]
    resources :ranks, only: %i[create update edit destroy new show]
    resources :events, only: %i[create update edit destroy new show]
    resources :message_for_everyones, only: %i[create edit destroy update]
    resources :message_for_each_menbers, only: %i[create edit destroy update]
  end
end
