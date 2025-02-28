class AddRemarksToVillage < ActiveRecord::Migration[8.0]
  def change
    add_column :villages, :remarks, :text
    add_column :villages, :hamlet, :boolean
  end
end
