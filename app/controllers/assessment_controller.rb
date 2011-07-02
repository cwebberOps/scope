class AssessmentController < ApplicationController
  layout 'admin'
  before_filter :confirm_logged_in

  def index
      list
      render('list')
  end
  
  def list
    @assessments = Assessment.order('name ASC')
  
  end

  def new
    @assessment = Assessment.new
    #TODO Allow the assignment of subjects
  end
  
  def create
    @assessment = Assessment.new(params[:assessment])
    if @assessment.save
      flash[:notice] = "Assesment Created"
      redirect_to(:action => "list")
    else
      
      render("new")
    end
  end
  
  def edit
    @assessment = Assessment.find(params[:id])
    #TODO Allow the assignment of subjects
  end
  
  def update
    @assessment = Assessment.find(params[:id])
    if @assessment.update_attributes(params[:assessment])
      flash[:notice] = "Assessment Updated"
      redirect_to(:action => 'list')
    else
      render('edit')
    end
    
  end
  
  def delete
    @assessment = Assessment.find(params[:id])
  end
  
  def destroy
    Assessment.find(params[:id]).destroy
    flash[:notice] = "Assessment Deleted"
    redirect_to(:action => 'list')
    #TODO Remove all of the asociated questions    
  end

  def import
    @assessment = Assessment.find(params[:id])
  end
  
  def verify
    
    @assessment = Assessment.find(params[:id])
    @file = params[:file]
    
    if @file.original_filename =~ /.xlsx/
      @excel = Excelx.new(@file.tempfile.path, false, :warning)
    else
      @excel = Excel.new(@file.tempfile.path, false, :warning)
    end
    
    2.upto(@excel.last_row) do |line|
      question = Question.new(:assessment_id => )
    end
    
  end
  
end
