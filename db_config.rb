require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'decisionmaking'
}

ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)
