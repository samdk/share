require 'rubygems'
require 'active_record'
require 'models.rb'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database =>  'db/database.sqlite3'
)

u = User.new(:username => 'sam')
u2 = User.new(:username => 'ted')
u.salted_password!('test')
u2.salted_password!('test')
u.save
u2.save


e1 = Entry.create(:total => 13.41, :user => u2, :users => [u,u2], :description => 'test stuff')
e2 = Entry.create(:total => 10.20, :user => u, :users => [u,u2], :description => 'test stuff')
e3 = Entry.create(:total => 100.0, :user => u, :users => [u2], :description => 'test stuff')
e4 = Entry.create(:total => 12.34, :user => u2, :users => [u], :description => 'test stuff')
e5 = Entry.create(:total => 11.11, :user => u, :users => [u], :description => 'test stuff')

