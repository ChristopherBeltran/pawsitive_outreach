class Pet < ActiveRecord::Base
  has_many :adoptions
  has_many :users, through: :adoptions
  has_many :pet_breeds
  has_many :breeds, through: :pet_breeds

  def breeds=(breeds)
    breeds.each do |name|
      breed = Breed.find_or_create_by(name: name)
      self.breeds << breed
    end
  end

  def display_breed
    if self.breeds.count > 1
      names = []
      self.breeds.each do |breed|
        names << breed.name
      end
      names.map(&:inspect).join('/')
    else
      self.breeds.each do |breed|
        return breed.name
      end
    end
  end

end
