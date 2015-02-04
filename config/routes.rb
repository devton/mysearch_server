Rails.application.routes.draw do
  get '/s(/:terms)' => 'searches#show', format: :json
end
