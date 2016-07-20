require 'spec_helper'

describe 'index path', {:type => :feature}  do

  it('will show recipe list and categories') do
    visit '/'
    expect(page).to have_content 'Add a recipe'
  end

  it 'will show a newly added recipe'  do
    visit '/'
    fill_in 'recipe_name', :with => 'Test Recipe'
    click_button 'Submit'
    visit '/'
    expect(page).to have_content 'Test Recipe'
  end

  it 'will show you the recipe details' do
    visit '/'
    fill_in 'recipe_name', :with => 'Test Recipe'
    click_button 'Submit'
    expect(page).to have_content "Test Recipe"
  end

  it 'will show a newly added category' do
    visit '/'
    fill_in 'recipe_name', :with => 'Test Recipe'
    click_button 'Submit'
  end

  it('will add an ingredient to a recipe') do
    visit '/'
    fill_in 'recipe_name', :with => 'Test Recipe'
    click_button 'Submit'
    click_link 'Edit'
    fill_in 'ingredient_name', :with => 'Oranges'
    fill_in 'measurement', :with => '3'
    click_button 'ingred_submit'
  end

end
