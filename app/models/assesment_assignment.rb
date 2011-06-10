class AssesmentAssignment < ActiveRecord::Base

  belongs_to :assessment
  belongs_to :section

  has_many :responses

end
