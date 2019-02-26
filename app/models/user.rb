class User < ActiveRecord::Base
  has_secure_password
  has_many :adoptions
  has_many :pets, through: :adoptions

  def self.find_or_create_from_auth_hash(auth)
    where(provider: auth.provider, uid: auth.id).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.id
      user.name = auth.info.name
      user.email = auth.info.email
      user.save!
    end
  end





end
