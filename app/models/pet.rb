class Pet < ActiveRecord::Base
  include Titleize
  include Displayname
  has_many :adoptions
  has_many :users, through: :adoptions
  has_many :pet_breeds
  has_many :breeds, through: :pet_breeds
  accepts_nested_attributes_for :breeds
  validates :name, presence: true
  validates :age, presence: true
  validates_inclusion_of :age, :in => 1..30
  before_save :tileize_name
  before_create :tileize_name

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
      names.map(&:inspect).join('/').delete('"')
    else
      self.breeds.each do |breed|
        return breed.name
      end
    end
  end
  #Class Scope Method
  def self.from_breed(breed)
    params = breed.name
    Pet.joins(:breeds).where({"breeds.name" => params })
  end

  #Class Scope Method
  def self.without_owner
    Pet.joins('left outer join adoptions on adoptions.pet_id = pets.id').where('adoptions.id is null')
  end

  def display_ownership
    if self.users.count == 0
      return "N"
    else
      return "Y"
    end
  end


end
