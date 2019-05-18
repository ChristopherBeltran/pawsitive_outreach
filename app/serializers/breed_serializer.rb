class BreedSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :pets
end
