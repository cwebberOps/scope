class Term < ActiveRecord::Base
  has_many :sections
  validates :name, :presence => true
end
