class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :notes, -> {where "archived_at IS null"}, through: :taggings
  after_destroy :delete_taggings
  
  def delete_taggings
    taggings.destroy_all
  end
end
