Rails.application.routes.draw do
  get 'papers/index'

  resources :papers do
    collection do
      get :new_doi
      post :create_doi
    end
  end
end
