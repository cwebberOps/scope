class Section < ActiveRecord::Base
 belongs_to :term
 belongs_to :period
 belongs_to :teacher
 belongs_to :subject

 has_many :assessment_assignments
 has_many :assesments, :through => :assessment_assignments
 has_many :section_students
 has_many :students, :through => :section_students
 
end
