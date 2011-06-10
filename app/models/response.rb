class Response < ActiveRecord::Base

  belongs_to :answer
  belongs_to :student
  belongs_to :assessment_assignment

end
