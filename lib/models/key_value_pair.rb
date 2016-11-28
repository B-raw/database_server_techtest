require 'data_mapper'
require 'dm-postgres-adapter'

class KeyValuePair
  include DataMapper::Resource

  property :id,           Serial
  property :key_entry,    String
  property :value_entry,  String
end

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/key_value_entry_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!
