class CreateCensusVillages < ActiveRecord::Migration[8.0]
  def change
    create_table :census_villages do |t|
      t.string :name
      t.string :subdivision
      t.string :district
      t.string :code

      t.timestamps
    end
  end
end
