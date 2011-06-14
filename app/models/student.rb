class Student < ActiveRecord::Base

  has_many :section_students
  has_many :sections, :through => :section_students
  has_many :responses

  scope :sorted, order("last_name ASC, first_name ASC")
  
  validates :first_name, :presence => true
	validates :last_name, :presence => true
  validates_numericality_of :grad_year, :only_integer => true
  validates_numericality_of :student_num, :only_integer => true
  validates :student_num, :presence => true
  
  def name
    "#{first_name} #{last_name}"
  end
  
end
