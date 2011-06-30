class Question < ActiveRecord::Base

  belongs_to :sub_standard
  belongs_to :assessment

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }

end
