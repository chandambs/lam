class Village < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :census_village, optional: true
  has_many :lgd_villages
  has_many :duplicates
  has_many :duplicate_villages, through: :duplicates, source: :duplicate_village

  scope :with_similar_name, ->(name, id) {
    select("villages.*, similarity(name, '#{sanitize_sql(name)}') AS similarity_score")
      .where("similarity(name, ?) > 0.25 and id != ?", name, id)
      .order("similarity_score DESC")
  }

end

