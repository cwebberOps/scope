class StandardController < ApplicationController

  layout 'admin'
  before_filter :confirm_logged_in

  before_filter :find_standard_subject

  def index
    list
    render('list')
  end

  def new
    @standard = Standard.new(:standard_subject_id => @standard_subject.id)
    @standard_subjects = StandardSubject.order('name ASC')
  end

  def list
    @standards = Standard.order("designation ASC").where(:standard_subject_id => @standard_subject.id)
  end

  def edit
    @standard = Standard.find(params[:id])
    @standard_subjects = StandardSubject.order('name ASC')
  end

  def update
    @standard = Standard.find(params[:id])
    if @standard.update_attributes(params[:standard])
      flash[:notice] = "Standard Updated"
      redirect_to(:action => 'list', :standard_subject_id => @standard.standard_subject_id)
    else
      @standard_subjects = StandardSubject.order('name ASC')
      render("edit")
    end
  end

  def create
    @standard = Standard.new(params[:standard])
    if @standard.save
      flash[:notice] = "Standard Created"
      redirect_to(:action => 'list', :standard_subject_id => @standard.standard_subject_id)
    else
      @standards = Standard.order("name ASC").where(:standard_subject_id => @standard_subject.id)
      render("new")
    end
  end

  def delete
    @standard = Standard.find(params[:id])
  end

  def destroy
    Standard.find(params[:id]).destroy
    flash[:notice] = "Standard deleted."
    redirect_to(:action => "list", :standard_subject_id => @standard_subject.id)
  end

  private 

  def find_standard_subject
    if params[:standard_subject_id]
      @standard_subject = StandardSubject.find_by_id(params[:standard_subject_id])
    end
  end
end
