class RemoveEndDateColumnFromAdoptions < ActiveRecord::Migration[5.2]
  def change
    remove_column :adoptions, :end_date
  end
end
