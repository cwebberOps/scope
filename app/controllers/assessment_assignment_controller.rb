class AssessmentAssignmentController < ApplicationController

  layout 'admin'
  before_filter :confirm_logged_in
  before_filter :find_teacher

  def index
    list
    render 'list'
  end

  def list
    @assessment_assignments = AssessmentAssignment.where(:section_id => @teacher.sections.collect {|s| s.id})
  end
  
  def new
  
    @assessments = Assessment.order("name ASC")
    
  end
  
  def create
    
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def delete
    
  end
  
  def destroy
    
  end

  private
  
  def find_teacher
    if params[:teacher_id]
      @teacher = Teacher.find_by_id(params[:teacher_id])
    else
      @teacher = Teacher.find_by_id(session[:user_id])
    end
  end
  
  
end
