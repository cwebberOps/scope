class Question < ActiveRecord::Base

  belongs_to :sub_standard
  belongs_to :assessment

end
