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
  recipe.update({:instruction => params[:instructions], :rating => params[:rating]})
  redirect back
  # redirect to "/recipes/#{params[:id]}/edit"
end

get '/recipes/:id/edit' do
  @recipe = Recipe.find(params[:id])
  @tags = Tag.all
  erb(:recipe_edit)
end

get '/recipes/:id/categories/new' do
  @recipe = params[:id]
  erb(:recipe_cat)
end

post '/recipes/:id/categories/new' do
  recipe = Recipe.find(params[:id])
  recipe.tags.new({:name => params[:name]})

  if recipe.save
    redirect to "/recipes/#{params[:id]}/edit"
  end
end

patch '/recipes/:id/categories/' do
  recipe = Recipe.find(params[:id]) || nil
  new_tag = Tag.find(params[:tag]) unless params[:tag] == nil

  if new_tag
    recipe.tags.push(new_tag)
  end
  redirect to "/recipes/#{params[:id]}/edit"
end

get '/tags/:id' do
  @tag = Tag.find(params[:id])
  erb(:tags)
end
