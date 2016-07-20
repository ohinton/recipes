require("spec_helper")

describe(Recipe) do
  it("validates presence of a name") do
    recipe = Recipe.new({:name => ""})
    expect(recipe.save()).to(eq(false))
  end
end
