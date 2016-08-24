require 'bundler/setup'
require 'sinatra'

get '/' do
  code = "<%= Time.now %>"
  erb code
end

get '/v1' do
  @version = 'gif api version is 1.0'
  erb :v1
end

get '/v1/gif' do
  num = rand(8) + 1
  @gif_url = 'https://s3-ap-northeast-1.amazonaws.com/line-bot-2016/gif/git-' + num.to_s + '.gif'
  erb :gif
end

get '/v1/gif/preview' do
  num = rand(8) + 1
  @gif_url = 'https://s3-ap-northeast-1.amazonaws.com/line-bot-2016/gif/git-' + num.to_s + '.gif'
  erb :preview
end