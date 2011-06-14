class PeriodController < ApplicationController

  layout 'admin'
  before_filter :confirm_logged_in

  def index
    list
    render('list')
  end

  def new
    @period = Period.new
  end

  def list
    @periods = Period.order("period_num ASC")
  end

  def edit
    @period = Period.find(params[:id])
  end

  def update
    @period = Period.find(params[:id])
    if @period.update_attributes(params[:period])
      flash[:notice] = "Period Updated"
      redirect_to(:action => "list")
    else
      render("edit")
    end
  end

  def create
    @period = Period.new(params[:period])
    if @period.save
      flash[:notice] = "Period Created"
      redirect_to(:action => 'list')
    else
      render("new")
    end
  end

end
