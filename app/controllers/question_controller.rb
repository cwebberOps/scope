class QuestionController < ApplicationController

  layout 'admin'
  before_filter :confirm_logged_in
  before_filter :find_assessment

  def index
    list
    render('list')
  end
  
  def list
    @questions = Question.order("id ASC").where(:assessment_id => @assessment.id)
  end

  def new
    @question = Question.new(:assessment_id => @assessment.id)
    @sub_standards = SubStandard.sorted
    #TODO: Come up with a better way to sort this.
  end

  def create
    @question = Question.new(params[:question])
    if @question.save
      flash[:notice] = "Question Created"
      redirect_to(:action => 'list', :assessment_id => @question.assessment_id)
    else
      @sub_standards = SubStandard.sorted
      render('new')
    end
  end
  
  def edit
    @question = Question.find(params[:id])
    @sub_standards = SubStandard.sorted
  end
  
  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(params[:question])
      flash[:notice] = "Question Updated"
      redirect_to(:action => 'list', :assessment_id => @question.assessment_id)
    else
      @sub_standards = SubStandard.sorted
      render('edit')
    end
  end
  
  def delete
    @question = Question.find(params[:id])
  end
  
  def destroy
    Question.find(params[:id]).destroy
    flash[:notice] = "Question Removed"
    redirect_to(:action => "list", :assessment_id => @assessment.id)
  end
  
  private
  
  def find_assessment
    if params[:assessment_id]
      @assessment = Assessment.find_by_id(params[:assessment_id])
    end
  end
  
end
