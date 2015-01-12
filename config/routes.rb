Rails.application.routes.draw do
  resources :questions

  resources :presentations do
    collection do
      post 'search'
      get  'search'
    end
  end


  post 'checkAnswer', controller: 'questions', action: 'checkAnswer', format: 'json'
  post 'documents.json', controller: 'documents', action: 'create', format: 'json'
  put 'documents/:id.json', controller: 'documents', action: 'update', format: 'json'

  root 'presentations#index'

  get 'presentations/:id/:slide/show', controller: 'presentations', action: 'show'
  get 'presentations/:id/:slide/files/:type/*name', controller: 'presentations', action: 'show'

  get 'reload', to: 'presentations#reload'

  get '*any', to: 'presentations#index'

end
