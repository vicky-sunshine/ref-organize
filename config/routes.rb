Rails.application.routes.draw do
  get 'papers/index'

  resources :papers do
    collection do
      get :new_doi
      post :create_doi
      get 'tags/:tags_name', to: "papers#index", as: :tag  # Tag Routes
    end
    member do
      get :bibtex, to: "papers#bibtex"
    end
  end
end
