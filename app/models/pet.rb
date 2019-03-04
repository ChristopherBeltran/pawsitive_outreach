class Pet < ActiveRecord::Base
  has_many :adoptions
  has_many :users, through: :adoptions
  has_many :pet_breeds
  has_many :breeds, through: :pet_breeds
  accepts_nested_attributes_for :breeds
  validates :name, presence: true
  validates :age, presence: true
  validates_inclusion_of :age, :in => 1..30

  def breed_attributes=(breed_attributes)
      if breed_attributes[:name] != ""
      breed = Breed.find_or_create_by(breed_attributes)
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

  def display_name
    if self.name[-1] == "s"
      "#{self.name}'"
    else
      "#{self.name}'s"
    end
  end 
end
