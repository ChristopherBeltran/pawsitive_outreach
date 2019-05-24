class Breed < ActiveRecord::Base
  include Titleize
  has_many :pet_breeds
  has_many :pets, through: :pet_breeds
  before_save :tileize_name
  before_create :tileize_name


#def self.pet_count
#  counts = {}
#  self.all.each{|a| counts[a.name] = a.pets.count}
#  Hash[counts.sort_by{|k, v| v}.reverse]
#end


end
