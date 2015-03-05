OpenBeerDatabase::Application.routes.draw do
  # I can't seem to make a subdomain work on localhost for my life.
  # I also can't seem to figure out how to rewrite _any_ of this
  # router just yet. So for now...
  # constraints subdomain: "api" do
  #   namespace :v1, module: "Api::V1" do
  #     resources :beers,     only: [:index, :show, :create, :update, :destroy]
  #     resources :breweries, only: [:index, :show, :create, :update, :destroy]
  #   end
  # end
  namespace :v1, module: "Api::V1" do
    resources :beers,     only: [:index, :show, :create, :update, :destroy]
    resources :breweries, only: [:index, :show, :create, :update, :destroy]
  end

  constraints subdomain: "www" do
    match "/*path" => redirect { |_, request| "http://#{request.host.sub("www.", "")}#{request.path}" }

    root to: redirect { |_, request| "http://#{request.host.sub("www.", "")}" }
  end

  constraints(lambda { |request| request.subdomain.blank? }) do
    resources :documentation, only: [:show]
    resource  :session,       only: [:new, :create]
    resources :users,         only: [:show, :new, :create]

    root to: "Documentation#show", id: "overview"
  end
end
