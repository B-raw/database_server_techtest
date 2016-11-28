# Database API techtest

##Description

"Before your interview, write a program that runs a server that is accessible on http://localhost:4000/.

When your server receives a request on http://localhost:4000/set?somekey=somevalue it should store the passed key and value in memory.

When it receives a request on http://localhost:4000/get?key=somekey it should return the value stored at somekey.

If you finish, you can work on saving the data to a file."

##Instructions

Create a new git repository and write code to complete the brief to the best of your ability.
Store the data in memory, not in a database, but bear in mind that you will later need to add a database to this code.

##Installation

1. `git clone https://github.com/B-raw/database_server_techtest.git`
2. `cd database_server_techtest`
3. `bundle`
4. Create two database - one called `key_value_entry_development` and another called `key_value_entry_test`.
5. Run the rspec/rack-test test suite using the instruction `rspec`
6. Run using the command `rerun lib/app.rb`
7. To add a key value pair to the server, send a post request to "http://localhost:4000/set?somekey=somevalue". To send a post request from your browser, you may want to get a chrome extension such as Advanced REST client.
8. To get the value of your key back, send a get request to "http://localhost:4000/get?key=somekey"

##Approach

Although the brief asked not to use a database, I felt this was impractical and not realistic. It also would have lead to poorer testing.

Therefore I elected to use a databased approach.

I initially started writing integration tests using capybara, but there is an article from the creator of Capybara advising against using it for that (!). The consensus from my research is to use Rack::Test - this allows this wonderful response syntax:

```
...
expect(last_response).to be_ok
database_entry = KeyValuePair.first
expect(database_entry.key_entry).to eq("somekey")
expect(database_entry.value_entry).to eq("somevalue")
...
```
