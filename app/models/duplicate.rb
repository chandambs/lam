class Duplicate < ApplicationRecord
  belongs_to :village
  belongs_to :duplicate_village, class_name: 'Village'
end

