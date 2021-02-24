Rails.application.routes.draw do
  resources :books
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

# 以下は $rails routes のコマンドで確認できる.resourceを使うといかが自動的に生成される
# get "/books" => "books#index"
# post "/books" => "books#create"
# get "/books/new" => "books#new"

# get "/books/:id/edit" => "books#edit" 
# get "/books/:id" => "books#show"
# patch "/books/:id" => "books#update"
# delete "/books/:id" => "books#destroy"

