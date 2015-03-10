GithubMates::Application.routes.draw do

  post '/' => 'index#search', :as => :search
  match 'contributors/:user/:repo' => 'contributors#index'
  match 'contributor/:id' => 'contributors#show'
  match 'contributor-infos/:user' => 'contributors#infos'

  root :to => "index#index"
  
end
