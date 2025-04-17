class AddSubdivisionPresentToVillage < ActiveRecord::Migration[8.0]
  def change
    add_column :villages, :subdivision_present, :text
  end
end
