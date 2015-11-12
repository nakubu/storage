require 'sinatra'
require 'json'
require './lib/storage'

storage = Storage.new
storage.load_from_file('./examples/init_from_file')

get '/' do
  response = '/add?string – добавить строку в Storage <br>'
  response += '/contains?string – возвращает JSON вида {result: true|false}. <br>'
  response += '/find?string– возвращает все строки, начинающиеся с string в виде JSON {words: [word1, word2]}'
end

get '/add' do
  storage.add(request.query_string)
end

get '/contains' do
  result = storage.contains?(request.query_string)
  response = {result: result}
  JSON response
end

get '/find' do
  words = storage.find(request.query_string)
  response = {words: words}
  JSON response
end
