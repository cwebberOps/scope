class SectionStudent < ActiveRecord::Base

  has_many :sections
  has_many :students

end
