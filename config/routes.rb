Rails.application.routes.draw do
  get 'uploadpage', to: 'uploads#new'
  post 'uploadpage', to: 'uploads#create'
end
