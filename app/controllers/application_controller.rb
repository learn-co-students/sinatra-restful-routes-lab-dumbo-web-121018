class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  set :method_override, true
  # this is index
  get '/recipes' do
    @all_recipes = Recipe.all
    # binding.pry
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  #this is show
  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    # binding.pry
    erb :show
  end

  #this is delete
  delete '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.destroy

    redirect "/recipes"
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  post '/recipes' do
    recipe = Recipe.new(params)
    recipe.save
    redirect "/recipes/#{recipe.id}"
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.update(name: params[:name],ingredients: params[:ingredients],cook_time: params[:cook_time])
    redirect "/recipes/#{params[:id]}"
  end


end
