Rails.application.routes.draw do
  # Rotas tradicionais de API
  # xpto.com.br/api/v1/users
  namespace :api do
    namespace :v1 do
      post 'authenticate', to: 'authentication#authenticate'
      resources :comments
      resources :orders
      resources :users
      resources :clients
      resources :profiles
      resources :permissions
      resources :products
    end
  end

  # Caso o domínio seja com o API no inicio é possível definir as rotas assim:
  #  api.xpto.com.br/v1/users <-- por exemplo
  # constraints subdomain: 'api' do
  #   scope module: 'api' do
  #     namespace :v1 do
  #       resources :comments
  #       resources :orders
  #       resources :users
  #       resources :clients
  #       resources :profiles
  #       resources :permissions
  #       resources :products
  #     end
  #   end
  # end
end
