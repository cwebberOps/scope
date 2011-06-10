class Standard < ActiveRecord::Base

  belongs_to :standard_subject
  has_many :sub_standards

end
