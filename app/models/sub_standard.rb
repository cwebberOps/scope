class SubStandard < ActiveRecord::Base
  belongs_to :standard
  has_many :questions

end
