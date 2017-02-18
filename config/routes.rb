Rails.application.routes.draw do
  get 'papers/index'

  resources :papers
end
