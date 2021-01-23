require_relative '../../config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
    erb :new
  end

  get '/articles/:id' do
    @article = Article.find_by_id(params[:id])
    erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.find_by_id(params[:id])
    erb :edit
  end

  post '/articles' do
    @article = Article.new(params['article'])
    if @article.save
      redirect "/articles/#{@article.id}"
    else
      puts 'Some kind of error happened'
      redirect '/articles/new'
    end
  end

  patch '/articles/:id' do
    @article = Article.find_by_id(params[:id])
    if @article.update(params['article'])
      redirect "/articles/#{@article.id}"
    else
      puts 'Some kind of error happened'
      redirect "/articles/#{@article.id}/edit"
    end
  end

  delete '/articles/:id' do
    @article = Article.find_by_id(params[:id])
    if @article.destroy
      redirect '/articles'
    else
      puts 'Some kind of error happened'
      redirect "/articles/#{@article.id}"
    end
  end
end
