Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/auth', to: 'auth#create'
      get '/current_user', to: 'auth#show'
      delete '/relationships', to: 'relationships#destroy'
      get '/content', to: 'users#content'
      post '/ChannelBlock', to: 'channel_block#create'


      resources :comments
      resources :blocks
      resources :channels
      resources :users
      resources :relationships, except: [:destroy]
    end
  end
end
