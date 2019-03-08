class User < ActiveRecord::Base
  include Titleize
  include Displayname
  has_secure_password
  has_many :adoptions
  has_many :pets, through: :adoptions
  validates :phone_number, length: { is: 10 }
  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  before_save :tileize_name
  before_create :tileize_name

  def self.find_or_create_from_auth_hash(auth)
    where(provider: auth.provider, uid: auth.id).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.id
      user.name = auth.info.name
      user.email = auth.info.email
      user.save!
    end
  end

  def find_adoption_by_pet(pet)
    self.adoptions.each do |adoption|
      if adoption.pet_id == pet.id
        return adoption
      end
    end
  end

end
