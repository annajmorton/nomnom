# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
post '/signin', to: 'signup#signin'
get '/signup/new', to: 'signup#new'
post '/signup', to: 'signup#create'
get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
post '/meals', to: 'meals#create'
get '/meals/new', to: 'meals#new'
get '/meals', to: 'meals#index'

get '/auth/:provider/callback', to: 'session#create'
post '/auth/:provider/callback', to: 'session#create'

root to: 'home#index'