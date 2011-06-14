class Subject < ActiveRecord::Base

  belongs_to :standard_subject
  has_many :sections
  has_and_belongs_to_many :assessments
end
