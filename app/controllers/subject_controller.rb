class SubjectController < ApplicationController

  layout 'admin'
  before_filter :confirm_logged_in

  def index
    list
    render('list')
  end

  def new
    @subject = Subject.new
    @standard_subjects = StandardSubject.order("name ASC")
  end

  def list
    @subjects = Subject.order("name ASC")
  end

  def edit
    @subject = Subject.find(params[:id])
    @standard_subjects = StandardSubject.order("name ASC")
  end

  def update
    @subject = Subject.find(params[:id])
    if @subject.update_attributes(params[:subject])
      flash[:notice] = "Subject Updated"
      redirect_to(:action => "list")
    else
      @standard_subjects = StandardSubject.order("name ASC")
      render("edit")
    end
  end

  def create
    @subject = Subject.new(params[:subject])
    if @subject.save
      flash[:notice] = "Subject Created"
      redirect_to(:action => 'list')
    else
      @standard_subjects = StandardSubject.order("name ASC")
      render("new")
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    Subject.find(params[:id]).destroy
    flash[:notice] = "Subject deleted."
    redirect_to(:action => "list")
  end
end
