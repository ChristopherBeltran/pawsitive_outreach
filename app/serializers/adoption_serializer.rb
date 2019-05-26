class AdoptionSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :pet_id, :adoption_date
  belongs_to :user
  belongs_to :pet
end
