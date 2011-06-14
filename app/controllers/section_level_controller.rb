class SectionLevelController < ApplicationController

  layout 'admin'
  before_filter :confirm_logged_in

  def index
    list
    render('list')
  end

  def new
    @section_level = SectionLevel.new
  end

  def list
    @section_levels = SectionLevel.order("name ASC")
  end

  def edit
    @section_level = SectionLevel.find(params[:id])
  end

  def update
    @section_level = SectionLevel.find(params[:id])
    if @section_level.update_attributes(params[:section_level])
      flash[:notice] = "Section Level Updated"
      redirect_to(:action => "list")
    else
      render("edit")
    end
  end

  def create
    @section_level = SectionLevel.new(params[:section_level])
    if @section_level.save
      flash[:notice] = "Section Level Created"
      redirect_to(:action => 'list')
    else
      render("new")
    end
  end

end
