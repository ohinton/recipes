class RemoveIndex < ActiveRecord::Migration
  def change
    remove_index(:ingredients, name: :uniq_name)
  end
end
