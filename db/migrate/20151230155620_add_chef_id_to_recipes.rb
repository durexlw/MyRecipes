class AddChefIdToRecipes < ActiveRecord::Migration
  def change
    add_reference :recipes, :chef, index: true, foreign_key: true
  end
end
