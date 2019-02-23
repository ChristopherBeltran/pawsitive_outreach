class CreateAdoptions < ActiveRecord::Migration[5.2]
  def change
    create_table :adoptions do |t|
      t.integer :user_id
      t.integer :pet_id
      t.date :adoption_date
      t.boolean :foster
      t.date :end_date
    end
  end
end
