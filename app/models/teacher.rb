require 'digest/sha1'
class Teacher < ActiveRecord::Base

  has_many :sections
  has_many :subjects, :through => :sections

  before_save :create_hashed_password
  after_save :clear_password

  scope :sorted, order("teachers.last_name ASC, teachers.first_name ASC")

  attr_accessor :password
  attr_protected :hashed_password, :salt

  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
	validates :first_name, :presence => true
	validates :last_name, :presence => true
	validates :username, :length => { :within => 2..25 }, :uniqueness => true
	validates :email, :presence => true, :length => { :maximum => 255 }, :format => EMAIL_REGEX, :confirmation => true
	validates_length_of :password, :within => 6..25, :on => :create

  def name
    "#{first_name} #{last_name}"
  end

  def self.authenticate(username="", password="")
    user = Teacher.find_by_username(username)
    if user && user.password_match?(password)
      return user
    else
      return false
    end
  end

  def password_match?(password="")
    hashed_password == Teacher.hash_with_salt(password, salt)
  end

  def self.make_salt(username="")
    Digest::SHA1.hexdigest("#{username} #{Time.now} Some random stringgy goodeness")
  end

  def self.hash_with_salt(password="",salt="")
    Digest::SHA1.hexdigest("Put #{salt} on the #{password}")
  end

  private

  def create_hashed_password
    unless password.blank?
      self.salt = Teacher.make_salt(username) if salt.blank?
      self.hashed_password = Teacher.hash_with_salt(password, salt)
    end
  end

  def clear_password
    self.password = nil
  end


end


