# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get 'edit', to: 'users/registrations#edit'
    get 'signup', to: 'users/registrations#new'
    get 'login', to: 'users/sessions#new'
    get 'logout', to: 'users/sessions#destroy'
  end
  get 'users/show' => 'users#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome_pages#top'
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
  end
  resources :answers, only: %i[create]
  resources :relationships, only: %i[create destroy]
end
