require 'sinatra'

get '/' do
  'Hello yoshi!'
end

get '/v1' do
  'gif api version is 1.0'
end