class RemoveFosterColumnFromAdoptions < ActiveRecord::Migration[5.2]
  def change
    remove_column :adoptions, :foster
  end
end
