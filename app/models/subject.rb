class Subject < ActiveRecord::Base

  has_many :sections
  has_and_belongs_to_many :assessments
end
