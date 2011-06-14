class StandardSubjectController < ApplicationController

  layout 'admin'
  before_filter :confirm_logged_in

  def index
    list
    render('list')
  end

  def new
    @standard_subject = StandardSubject.new
  end

  def list
    @standard_subjects = StandardSubject.order("name ASC")
  end

  def edit
    @standard_subject = StandardSubject.find(params[:id])
  end

  def update
    @standard_subject = StandardSubject.find(params[:id])
    if @standard_subject.update_attributes(params[:standard_subject])
      flash[:notice] = "Standard Subject Updated"
      redirect_to(:action => "list")
    else
      render("edit")
    end
  end

  def create
    @standard_subject = StandardSubject.new(params[:standard_subject])
    if @standard_subject.save
      flash[:notice] = "Standard Subject Created"
      redirect_to(:action => 'list')
    else
      render("new")
    end
  end

  def delete
    @standard_subject = StandardSubject.find(params[:id])
  end

  def destroy
    StandardSubject.find(params[:id]).destroy
    flash[:notice] = "Standard Subject deleted."
    redirect_to(:action => "list")
  end
end
