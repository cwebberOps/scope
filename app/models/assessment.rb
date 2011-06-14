class Assessment < ActiveRecord::Base

  has_and_belongs_to_many :subjects
  has_many :assessment_assignments
  has_many :questions

end
