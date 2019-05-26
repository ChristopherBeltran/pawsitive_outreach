class UserSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :pets
  has_many :adoptions
end
