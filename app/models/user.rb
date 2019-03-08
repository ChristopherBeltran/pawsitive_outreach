class User < ActiveRecord::Base
  include Titleize
  include Displayname
  has_secure_password
  has_many :adoptions
  has_many :pets, through: :adoptions
  #validates :phone_number, length: { is: 10 }
  validates_format_of :phone_number, with: /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/, unless: -> { from_omniauth? }
  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  before_save :tileize_name
  before_create :tileize_name

  def from_omniauth?
    provider && uid
  end

  def phone_number=(phone_number)
  super(phone_number.blank? ? nil : phone_number.gsub(/[^\w\s]/, ''))
  end

  def self.find_or_create_from_auth_hash(auth)
  		where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
  			user.provider = auth.provider
  			user.uid = auth.uid
  			user.name = auth.info.name
        user.email = auth.info.email
        user.password = SecureRandom.urlsafe_base64
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
