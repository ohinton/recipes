require("bundler/setup")

Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file}

get '/' do
  @recipes = Recipe.all
  @tags = Tag.all
  erb(:index)
end

post '/recipes/new' do
  new_recipe = Recipe.new({:name => params[:recipe_name]})
  if new_recipe.save
    redirect to "/recipes/#{new_recipe.id}"
  else
    redirect '/'
  end
end

get '/recipes/:id' do
  @recipe = Recipe.find(params[:id])
  erb(:recipe_info)
end

patch '/recipes/:id' do
  recipe = Recipe.find(params[:id])
  recipe.update({:instruction => params[:instructions]})
  redirect to "/recipes/#{params[:id]}/edit"
end

get '/recipes/:id/edit' do
  @recipe = Recipe.find(params[:id])
  @categories = Tag.all
  erb(:recipe_edit)
end

get '/recipes/:id/categories/new' do
  @recipe = params[:id]
  erb(:recipe_cat)
end

post '/recipes/:id/categories/new' do
  recipe = Recipe.find(params[:id])
  recipe.tags.create({:name => params[:name]})
  redirect to '/recipes/:id/edit'.
end
