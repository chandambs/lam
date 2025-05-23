class CensusVillage < ApplicationRecord
  has_many :villages

  scope :with_similar_name, ->(name) {
    select("census_villages.*, similarity(name, '#{sanitize_sql(name)}') AS similarity_score")
      .where("similarity(name, ?) > 0.45", name)
      .order("similarity_score DESC")
  }
end
