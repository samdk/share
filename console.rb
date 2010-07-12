require 'rubygems'
require 'active_record'
require 'models.rb'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database =>  'db/database.sqlite3'
)
