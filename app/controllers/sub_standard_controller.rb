class SubStandardController < ApplicationController

  layout 'admin'
  before_filter :confirm_logged_in

  before_filter :find_standard

  def index
    list
    render('list')
  end

  def new
    @sub_standard = SubStandard.new(:standard_id => @standard.id)
    @standards = Standard.order('designation ASC')
  end

  def list
    @sub_standards = SubStandard.order("designation ASC").where(:standard_id => @standard.id).where(:is_verified => true)
  end

  def edit
    @sub_standard = SubStandard.find(params[:id])
    @standards = Standard.order('designation ASC')
  end

  def update
    @sub_standard = SubStandard.find(params[:id])
    if @sub_standard.update_attributes(params[:sub_standard])
      flash[:notice] = "Sub-Standard Updated"
      redirect_to(:action => 'list', :standard_subject_id => @standard.standard_subject_id, :standard_id => @standard.id)
    else
      @standards = Standard.order('designation ASC')
      render("edit")
    end
  end

  def create
    @sub_standard = SubStandard.new(params[:sub_standard])
    if @sub_standard.save
      flash[:notice] = "Sub-Standard Created"
      redirect_to(:action => 'list', :standard_id => @sub_standard.standard_id)
    else
      @sub_standards = SubStandard.order("designation ASC").where(:standard_id => @standard.id)
      render("new")
    end
  end

  def delete
    @sub_standard = SubStandard.find(params[:id])
  end

  def destroy
    SubStandard.find(params[:id]).destroy
    flash[:notice] = "Standard deleted."
    redirect_to(:action => "list", :standard_id => @standard.id)
  end

  private 

  def find_standard
    if params[:standard_id]
      @standard = Standard.find_by_id(params[:standard_id])
    end
  end
end
