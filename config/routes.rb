# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :album_users
    resources :answers
    resources :rank_choices
    resources :events
    resources :event_comments
    resources :graduation_albums
    resources :message_for_each_menbers
    resources :message_for_everyones
    resources :photo_collections
    resources :photo_paths
    resources :ranks
    resources :registered_collections
    resources :relationships
    resources :suprise_messages

    root to: 'users#index'
  end
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  get '/auth/auth0/callback' => 'auth0#callback'
  get '/auth/failure' => 'auth0#failure'
  get '/auth/logout' => 'auth0#logout'

  devise_scope :user do
    get 'edit', to: 'users/registrations#edit'
    get 'signup', to: 'users/registrations#new'
    get 'login', to: 'users/sessions#new'
    get 'logout', to: 'users/sessions#destroy'
  end
  get 'users/show' => 'users#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome_pages#top'
  resources :sample_album_pages, only: %i[index] do
    collection do
      get :detail
    end
  end
  get 'static_pages/privacy' => 'static_pages#privacy'
  get 'static_pages/terms_service' => 'static_pages#terms_service'
  post '/welcome_pages/guest_sign_in', to: 'welcome_pages#guest_sign_in'
  resources :graduation_albums do
    member do
      delete :destroy_each_photo
    end
    resources :menbers, only: %i[show] do
      resources :register_faces, only: %i[create]
    end
    resources :ranks, only: %i[create update edit destroy new show] do
      resources :rank_choices, only: %i[create update edit destroy new show]
    end
    resources :events, only: %i[create update edit destroy new show] do
      resources :event_comments, only: %i[create edit destroy update]
    end
    resources :message_for_everyones, only: %i[create edit destroy update]
    resources :message_for_each_menbers, only: %i[create edit destroy update]
    resources :suprise_messages, only: %i[create edit destroy update new show]
    resources :auto_make_events, only: %i[create]
    resources :auto_make_ranks, only: %i[create]
  end
  resources :answers, only: %i[create]
  resources :relationships, only: %i[create destroy]
end
