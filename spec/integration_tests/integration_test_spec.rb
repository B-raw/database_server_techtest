require_relative '../spec_helper'

describe "Setter Getter API" do
  include Rack::Test::Methods

  def app
    DatabaseServer.new
  end

  it "has a successful, albeit empty, index call" do
    get "/"
    expect(last_response).to be_ok
    expect(last_response.body).to eq('')
  end

  it "can post a key value pair" do
    post '/set?somekey=somevalue'
    expect(last_response).to be_ok
    database_entry = KeyValuePair.first
    expect(database_entry.key_entry).to eq("somekey")
    expect(database_entry.value_entry).to eq("somevalue")
  end

  it "can get a value for a key" do
    post '/set?somekey=somevalue'
    get '/get?key=somekey'
    expect(last_response).to be_ok
    expect(last_response.body).to eq("somevalue")
  end

  it "returns an error message if no value found for key" do
    get '/get?key=whywhowhen'
    expect(last_response).to be_ok
    expect(last_response.body).to eq("Sorry, no value found for that key 'whywhowhen'")
  end
end
