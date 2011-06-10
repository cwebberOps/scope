class Teacher < ActiveRecord::Base
  has_many :sections
  has_many :subjects, :through => :sections
end
