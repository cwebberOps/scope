class StandardSubject < ActiveRecord::Base
  has_many :standards
  has_many :subjects

end
