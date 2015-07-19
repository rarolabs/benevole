Rails.application.routes.draw do
  devise_for :usuarios

  resources :usuarios, only: [:edit,:update]
  
  post "/crud/usuario/create" => "usuarios#create"
  
  # Routes for RaroCrud
  get '/crud/:model' => "crud#index"
  get '/crud/:model/:id/edit' => "crud#edit"
  delete '/crud/:model/:id/destroy' => "crud#destroy"
  get '/crud/:model/new' => "crud#new"
  get '/crud/:model/query' => "crud#query"
  post '/crud/:model/create' => "crud#create"
  patch '/crud/:model/:id/create' => "crud#create"
  get '/crud/:model/:id/acao/:acao' => "crud#action"
  get '/crud/acao/:id' => "acoes#show"
  get '/crud/:model/:id' => "crud#show"

  resources :permissoes, only: [:create]
  
  namespace :api do
    resources :cidades, only: [] do
      collection do
        get 'busca'
      end
    end
    resources :usuarios, only: [] do
      collection do
        get 'busca_por_tag'
      end
    end
  end
  
  resources :acoes, only: [] do
    member do
      post "enviar_convite"
      get "rejeitar"
      get "aceitar"
      get "concluir_feedback"
    end
  end
  
  resources :mensagens, only: [:create]
  get "home/index"
  root to: "landpage#index"
end