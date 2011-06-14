class StudentController < ApplicationController

  layout 'admin'
  before_filter :confirm_logged_in

  def index
    list
    render('list')
  end

  def list
    @students = Student.sorted
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(params[:student])
    if @student.save
      flash[:notice] = 'Student created.'
      redirect_to(:action => 'list')
    else
      render("new")
    end
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    if @student.update_attributes(params[:student])
      flash[:notice] = "Student updated."
      redirect_to(:action => "list")
    else
      render("edit")
    end
  end

  def delete
    @student = Student.find(params[:id])
  end

  def destroy
    Student.find(params[:id]).destroy
    flash[:notice] = "Student deleted."
    redirect_to(:action => "list")
  end

end
