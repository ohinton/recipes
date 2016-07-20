class CreateDatabaseLayout < ActiveRecord::Migration
  def change
    create_table (:ingredients) do |t|
      t.column(:name, :string)
    end
    create_table(:foodstuffs) do |t|
      t.column(:measurement, :string)
      t.column(:ingredient_id, :int)
      t.column(:recipe_id, :int)
    end
    create_table(:recipes) do |t|
      t.column(:instruction, :string)
      t.column(:rating, :int)
    end
    create_table(:recipes_tags) do |t|
      t.column(:recipe_id, :int)
      t.column(:tag_id, :int)
    end
    create_table(:tags) do |t|
      t.column(:name, :string)
    end
  end
end
