module Admin::BreedsHelper

  def full_bred?
    if self.breeds.count > 1
      self.breeds.each do |breed|
        if breed.name != @breed.name
          return breed.name
        end
      end
    else
      "Y"
    end
  end
  
end
