class Adoption < ActiveRecord::Base
  belongs_to :user
  belongs_to :pet
  validates_presence_of :adoption_date
end
