require 'sinatra'
require 'json'

get '/auth' do
  content_type :json
 
  return {:auth => {"login" => "elerman123", "password" => "12345678"}}.to_json
  

#post '/auth' do
#  content_type :json
 
#  return {:auth => {"login" => "elerman123", "password" => "12345678"}}.to_json
  
end