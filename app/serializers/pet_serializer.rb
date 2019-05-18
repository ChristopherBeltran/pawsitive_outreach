class PetSerializer < ActiveModel::Serializer
  attributes :id, :name, :age
  has_many :breeds
  has_many :users
end
