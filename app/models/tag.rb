class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :notes, -> {where "archived_at IS null"}, through: :taggings
end
