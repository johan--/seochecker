require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter:  'mysql2',
  database: 'seochecker',
  username: 'root',
  password: nil,
  host:     'localhost'
)
