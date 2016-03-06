#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

#Создание подключения к БД при помощи Active Record
set :database, "sqlite3:MyNewBlog.db"

#Создание сущности Пост с наследованием
class Post < ActiveRecord::Base
	validates :autor, presence: true
	validates :content, presence: true
end

#Создание сущности Комментарий с наследованием
class Comment < ActiveRecord::Base
	validates :content, presence: true
end

get '/' do
	@results = Post.all
	erb :index			
end

#обработчик get-запроса /new
#браузер получает страницу с сервера
get '/new' do
  erb :new
end

#обработчик get-запроса страницы комментариев соответствующего поста
#браузер получает страницу с сервера
get '/details/:id' do
	post_id = params[:id]
	@row = Post.find(post_id)
#Поиск всех комментариев соответствующих определенному посту в обратном порядке согласно дате создания
	@comments = Comment.where("post_id = ?", post_id).order(created_at: :desc)	
	erb :details
end

#обработчие post-запроса /new
#браузер отправляет страницу на сервер
post '/new' do
#Сохранение данных в таблицу posts в базе данных с проверкой валидации
  ps = Post.new params[:post]
  	if ps.save
  		erb "Thank you for adding a post."
  	else
  		@error = ps.errors.full_messages.first
		erb :new
  	end
end

#обработчие post-запроса страницы комментариев соответствующего поста
#браузер отправляет страницу на сервер
post '/details/:id' do
#Сохранение нового комментария в таблицу comments в базе данных
		post_id = params[:id]
		cm = Comment.new do |c|
	  	c.post_id = post_id
	  	c.content = params[:content]
	end	
  	cm.save
end