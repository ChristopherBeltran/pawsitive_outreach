class Breed < ActiveRecord::Base
  has_many :pet_breeds
  has_many :pets, through: :pet_breeds


def self.pet_count
  counts = {}
  ##  counts << "#{breed.name}, #{breed.pets.count}"
  #end
  #counts.sort_by {|a| -a[1]}
  self.all.each{|a| counts[a.name] = a.pets.count}
  Hash[counts.sort_by{|k, v| v}.reverse]
end


end
