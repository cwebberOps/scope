class SubStandard < ActiveRecord::Base
  belongs_to :standard
  has_many :questions

  scope :sorted, order("designation ASC")
  
  def full_name
    "#{standard.standard_subject.name} - #{standard.designation}#{designation}: #{value}"
  end

  def short_name
    "#{standard.standard_subject.name} - #{standard.designation}#{designation}"
  end
  
end
