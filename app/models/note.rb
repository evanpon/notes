class Note < ActiveRecord::Base
  has_many :taggings
  has_many :tags, -> {where "archived_at IS null"}, through: :taggings

  def tags_as_css_classes
    tags.map{|t| t.name}.join(' ')
  end
end
