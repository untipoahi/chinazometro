ChinazoParty::Application.routes.draw do
  #get "home/index"
  #root :to => 'home#index'
  #get "chinazos/new"
  #root :to => 'chinazos#new'
  #get "chinazos/create"
  #root :to => 'chinazos#create'
  #get "chinazos" => "chinazos#index"
  #post "chinazos" => "chinazos#create"
  #get "chinazos/:id" => 'chinazos#show', as: :chinazo
  #get "chinazos/:id/edit" => 'chinazos#edit'
  #put "chinazos/:id" => "chinazos#update"
  #delete "chinazos/:id" => "chinazos#destroy"
  resources :chinazos
  root to: "home#index"
  get "login" => 'user#login'
  get "user/registro" => 'user#registro'
  post "user/authenticate" => "user#authenticate"
  get "user/:login" => "user#show"
  post "user/create" => "user#create"
  get "ajax/users" => "ajax#users"
  post "vote/new" => "vote#new"
  post "comentarios" => "comentario#create"
  get "comentarios/:chinazo_id" => "comentario#listPartial"
  get "puntajes" => "chinazos#buscarPuntos"
  get "comentarios" => "comentario#ultimosComentarios"
end
