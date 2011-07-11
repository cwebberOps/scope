class SectionStudent < ActiveRecord::Base

  belongs_to :section
  belongs_to :student

  validates :student_id, :uniqueness => {:scope => :section_id}
end
