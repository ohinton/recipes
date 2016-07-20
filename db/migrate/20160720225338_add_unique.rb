class AddUnique < ActiveRecord::Migration
  def change
    add_index(:ingredients, :name, unique: true, name: 'uniq_name')
  end
end
