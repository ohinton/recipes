require("bundler/setup")

Bundler.require(:default)

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file}

get '/' do
  @recipes = Recipe.order(rating: :desc)
  @tags = Tag.all
  @ingredients = Ingredient.all
  erb(:index)
end

post '/recipes/new' do
  new_recipe = Recipe.new({:name => params[:recipe_name], :rating => 0})
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
  instructions = params[:instructions] == nil ? recipe.instruction : params[:instructions]
  rating = params[:rating] == nil ? recipe.rating : params[:rating]
  recipe.update({:instruction => instructions, :rating => rating})
  redirect back
  # redirect to "/recipes/#{params[:id]}/edit"
end

get '/recipes/:id/edit' do
  @recipe = Recipe.find(params[:id])
  @tags = Tag.all
  @ingredients = Ingredient.all
  erb(:recipe_edit)
end

get '/recipes/:id/categories/new' do
  @recipe = params[:id]
  erb(:recipe_cat)
end

post '/recipes/:id/categories/new' do
  recipe = Recipe.find(params[:id])
  recipe.tags.new({:name => params[:name].downcase})

  if recipe.save
    redirect to "/recipes/#{params[:id]}/edit"
  end
end

patch '/recipes/:id/categories/' do
  recipe = Recipe.find(params[:id]) || nil
  new_tag = Tag.find(params[:tag]) unless params[:tag] == ""

  if new_tag
    recipe.tags.push(new_tag)
  end
  redirect to "/recipes/#{params[:id]}/edit"
end

patch '/recipes/:id/ingredient' do
  recipe = Recipe.find(params[:id]) || nil
  new_ingredient = Ingredient.find(params[:ingredient]) unless params[:ingredient] == ""

  if new_ingredient
    recipe.ingredients.push(new_ingredient)
  end
  redirect to "/recipes/#{params[:id]}/edit"
end

get '/tags/:id' do
  @tag = Tag.find(params[:id])
  erb(:tags)
end

delete '/tags/:id' do
  Tag.destroy(params[:id])
  redirect '/'
end

delete '/recipes/:id' do
  Recipe.destroy(params[:id])
  redirect '/'
end

post '/recipes/:id/ingredient/new' do
  recipe = Recipe.find(params[:id])
  ingredient = Ingredient.find(params[:ingredient])
  recipe.ingredients.push(ingredient)
  foodstuff = Foodstuff.where({:ingredient_id => ingredient.id, :recipe_id => recipe.id})
  foodstuff.update(:measurement => params[:measurement])
  redirect back
end

get '/recipes/:id/ingredient/add' do
  @recipe = Recipe.find(params[:id])
  erb(:ingredient_new)
end

post '/recipes/:id/ingredient/add' do
  new_ingredient = Ingredient.create({:name => params[:name].downcase})
  redirect to "/recipes/#{params[:id]}/edit"
end


get '/ingredients/:id' do
  @ingredient = Ingredient.find(params[:id])
  erb(:ingredient)
end

delete '/recipes/:id/ingredient' do
  recipe = Recipe.find(params[:id])
  ingredient = Ingredient.find(params[:ingredient])
  recipe.ingredients.destroy(ingredient)
  redirect to "/recipes/#{recipe.id}/edit"
end

delete '/ingredients/:id' do
  ingredient = Ingredient.find(params[:id])
  ingredient.destroy
  redirect to "/"
end
