class Period < ActiveRecord::Base

  has_many :sections

  validates_numericality_of(:period_num, :only_integer => true)
  validates_presence_of(:period_num)

end
