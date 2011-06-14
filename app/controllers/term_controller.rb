class TermController < ApplicationController

  layout 'admin'
  before_filter :confirm_logged_in

  def index
    list
    render('list')
  end

  def new
    @term = Term.new
  end

  def list
    @terms = Term.order("name ASC")
  end

  def edit
    @term = Term.find(params[:id])
  end

  def update
    @term = Term.find(params[:id])
    if @term.update_attributes(params[:term])
      flash[:notice] = "Term Updated"
      redirect_to(:action => "list")
    else
      render("edit")
    end
  end

  def create
    @term = Term.new(params[:term])
    if @term.save
      flash[:notice] = "Term Created"
      redirect_to(:action => 'list')
    else
      render("new")
    end
  end

end
