class Ingredient < ActiveRecord::Base
  has_many :foodstuffs
  has_many :recipes, through: :foodstuffs
  validates :name, uniqueness: true

end
