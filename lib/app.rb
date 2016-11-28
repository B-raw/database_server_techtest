ENV["RACK_ENV"] ||= "development"
require 'sinatra/base'

require_relative 'models/key_value_pair'


class DatabaseServer < Sinatra::Base
  set :port, 4000

  enable :sessions
  set :session_secret, 'super secret'

  get '/' do

  end

  post '/set' do
    string_to_add = request.query_string
    key_entry = string_to_add[/[A-Za-z]+/]
    value_entry = string_to_add[/=[A-Za-z]+/].sub(/=/, "")
    KeyValuePair.create(key_entry: key_entry, value_entry: value_entry)
  end

  get '/get' do
    string_to_find = request.query_string
    key_to_find = string_to_find[/=[A-Za-z]+/].sub(/=/, "")
    our_response = KeyValuePair.first(key_entry: key_to_find)
    if our_response
      return our_response.value_entry
    else
      return "Sorry, no value found for that key '#{key_to_find}'"
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
