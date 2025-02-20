class CreateVillages < ActiveRecord::Migration[8.0]
  def change
    create_table :villages do |t|
      t.string :name
      t.string :subdivision
      t.string :district
      t.string :district_present
      t.references :order, null: true, foreign_key: true
      t.references :census_village, null: true, foreign_key: true

      t.timestamps
    end
  end
end
