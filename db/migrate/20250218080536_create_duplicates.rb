class CreateDuplicates < ActiveRecord::Migration[8.0]
  def change
    create_table :duplicates do |t|
      t.references :village, null: false, foreign_key: true
      t.references :duplicate_village, null: false, foreign_key: { to_table: :villages}
      t.string :duplicate_type

      t.timestamps
    end
  end
end
