class SectionController < ApplicationController

  layout 'admin'
  before_filter :confirm_logged_in
  before_filter :find_teacher
  
  def index
    list
    render('list')
  end
  
  def list
    @sections = Section.where(:teacher_id => @teacher.id)
  end
  
  def new
    @section = Section.new(:teacher_id => @teacher.id)
    @section_levels = SectionLevel.order("id ASC")
    @terms = Term.order("name ASC")
    @periods = Period.order("period_num ASC")
    @subjects = Subject.order("name ASC")
  end
  
  def create
    @section = Section.new(params[:section])
    if @section.save
      flash[:notice] = "Section Created"
      redirect_to(:action => 'list', :teacher_id => @section.teacher_id)
    else
      @section_levels = SectionLevel.order("id ASC")
      @terms = Term.order("name ASC")
      @periods = Period.order("period_num ASC")
      @subjects = Subject.order("name ASC")
      render('new')
    end
  end
  
  def edit
    @section_levels = SectionLevel.order("id ASC")
    @terms = Term.order("name ASC")
    @periods = Period.order("period_num ASC")
    @subjects = Subject.order("name ASC")
    @section = Section.find(params[:id])
  end
  
  def update
    @section = Section.find(params[:id])
    if @section.update_attributes(params[:section])
      flash[:notice] = "Section Updated"
      redirect_to(:action => 'list', :teacher_id => @section.teacher_id)
    else
      @section_levels = SectionLevel.order("id ASC")
      @terms = Term.order("name ASC")
      @periods = Period.order("period_num ASC")
      @subjects = Subject.order("name ASC")
      render('edit')
    end
  end
  
  def delete
    @section = Section.find(params[:id])
  end
  
  def destroy
    @section = Section.find(params[:id]).destroy
    flash[:notice] = "Section Removed"
    redirect_to(:action => 'list', :teacher_id => @section.teacher_id)
  end
  
  def list_students
    @section = Section.find(params[:id])
  end
  
  def map_students_import
    @section = Section.find(params[:id])
  end
  
  def map_students_verify
    
  end
  
  def map_students_complete
    
  end
  
  def map_student
    @section = Section.find(params[:id])
    if params[:student_num]
      if @student = Student.find_by_student_num(params[:student_num])
        begin
          @section.students << @student
          flash[:notice] = "#{@student.name} was added to the section."
        rescue
          flash[:notice] = "#{@student.name} is already enrolled in the section."
        end
      else
        flash[:notice] = "#{params[:student_num]} is not a valid student number."
      end
    end
    redirect_to(:action => 'list_students', :id => @section.id, :teacher_id => @teacher.id)
  end
  
  def unmap_students
    message = ''
    @section = Section.find(params[:id])
    if unmap_student_ids = params[:unmap_student_id]
      unmap_student_ids.each do |unmap_student_id|
        if @student = Student.find_by_id(unmap_student_id)
          @section.students.delete(@student)
          message = message + "#{@student.name} removed from section.<br />\n"
        end
      end
    end
    flash[:notice] = message
    redirect_to(:action => 'list_students', :id => @section.id, :teacher_id => @teacher.id)
    
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
