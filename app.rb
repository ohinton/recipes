require("bundler/setup")

Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file}

get '/' do
  @recipes = Recipe.all
  @tags = Tag.all
  erb(:index)
end

post '/recipes/new' do
  new_recipe = Recipe.create({:name => params[:recipe_name]})
  new_recipe ? redirect to "/recipes/#{new_recipe.id}" : redirect to '/'
end

get '/recipes/:id' do
  @recipe = Recipe.find(params[:id])
  erb(:recipe_info)
end
