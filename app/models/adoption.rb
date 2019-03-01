class Adoption < ActiveRecord::Base
  belongs_to :user
  belongs_to :pet
  validates_presence_of :end_date, unless: -> { :foster == true }
end
