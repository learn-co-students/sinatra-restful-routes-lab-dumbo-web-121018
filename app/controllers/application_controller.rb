require "pry"


class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end
  get "/recipes" do
    @recipes = Recipe.all
    binding.pry
    erb :index
  end

  get "/recipes/new" do
    erb :new
  end

  post "/recipes" do
    @recipe = Recipe.create(:name => params[:name],
      :ingredients => params[:ingredients], :cook_time => params[:cook_time])
      redirect to "recipes/#{@recipe.id}"
  end

  get "/recipes/:id"
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  get "/recipes/:id/edit" do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do #edit action
  @recipe = Recipe.find_by_id(params[:id])
  @recipe.name = params[:name]
  @recipe.description = params[:description]
  @recipe.save
  redirect to "/recipes/#{@recipe.id}"
end

delete '/recipes/:id/delete' do #delete action
  @recipe = Article.find_by_id(params[:id])
  @recipe.delete
  redirect to '/recipes'
end



  # code actions here!
