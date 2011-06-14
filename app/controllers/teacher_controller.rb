class TeacherController < ApplicationController

  layout 'admin'
  before_filter :confirm_logged_in

  def index
    list
    render('list')
  end

  def list
    @teachers = Teacher.sorted
  end

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(params[:teacher])
    if @teacher.save
      flash[:notice] = 'Teacher created.'
      redirect_to(:action => 'list')
    else
      render("new")
    end
  end

  def edit
    @teacher = Teacher.find(params[:id])
  end

  def update
    @teacher = Teacher.find(params[:id])
    if @teacher.update_attributes(params[:teacher])
      flash[:notice] = "Teacher updated."
      redirect_to(:action => "list")
    else
      render("edit")
    end
  end

  def delete
    @teacher = Teacher.find(params[:id])
  end

  def destroy
    Teacher.find(params[:id]).destroy
    flash[:notice] = "Teacher deleted."
    redirect_to(:action => "list")
  end

end
