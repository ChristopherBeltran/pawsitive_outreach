class CreatePetBreeds < ActiveRecord::Migration[5.2]
  def change
    create_table :pet_breeds do |t|
      t.integer :pet_id
      t.integer :breed_id
    end
  end
end
