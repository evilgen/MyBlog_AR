#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

#Создание подключения к БД при помощи Active Record
set :database, "sqlite3:MyNewBlog.db"

class Post < ActiveRecord::Base
end

class Comment < ActiveRecord::Base
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

get '/details/:id' do
	@row = Post.find(params[:id])
	erb :details
end

post '/new' do
  ps = Post.new params[:post]
  ps.save
  erb :new
end

post '/details/:id' do
  post_id = params[:id]
  cm = Comment.new do |c|
  	c.post_id = post_id
  	c.content = params[:content]
  end	
  cm.save
  redirect to ('/details/' + post_id)
end