class Student < ActiveRecord::Base

  has_many :section_students
  has_many :sections, :through => :section_students
  has_many :responses

end
