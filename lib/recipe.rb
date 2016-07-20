class Recipe < ActiveRecord::Base
  has_many :foodstuffs
  has_many :ingredients, through: :foodstuffs
  has_and_belongs_to_many :tags
end
