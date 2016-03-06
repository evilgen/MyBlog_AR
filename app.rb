#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

#Создание подключения к БД при помощи Active Record
set :database, "sqlite3:MyNewBlog.db"

class Post < ActiveRecord::Base
end

get '/' do
	erb :new			
end

get '/new' do
  erb :new
end

get '/index' do
	@results = Post.all
	erb :index
end



post '/new' do
  @ps = Post.new params[:post]
  @ps.save
  erb :new
end