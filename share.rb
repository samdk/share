require 'rubygems'
require 'sinatra'
require 'haml'
require 'active_record'

set :haml, {:format => :html5}

def url(u)
  if u[-1] == '/'
    "#{u}?"
  else
    u
  end
end

get url('/') do 
  @entries = Entry.all(:order => 'created_at DESC')
  haml :index
end

get url('/entries/new') do
  @entry = Entry.new
  haml :entry_new
end

def process_user_checkboxes(params)
  ids = User.all.collect {|u| u.id}
  checked = ids.select {|id| params["users_#{id}"]}
  checked.collect {|id| User.find(id)}
end

post url('/entries/new') do
  @entry = Entry.new
  @entry.total = params[:total]
  @entry.user = User.find(params[:user_id])
  @entry.users = process_user_checkboxes(params)
  @entry.description = params[:description]
  @entry.save
  redirect url('/')
end

get url('/users') do
  @users = User.all
  haml :users
end

get url('/users/new') do
  @user = User.new
  haml :user_new
end

post url('/users/new') do
  @user = User.new
  @user.username = params[:username]
  @user.salted_password!(params[:password])
  @user.save
  redirect url('/users')
end

#
# models
#
  require 'models.rb'

# database setup
#
  ActiveRecord::Base.establish_connection(
    :adapter => 'sqlite3',
    :database =>  'db/database.sqlite3'
  )
