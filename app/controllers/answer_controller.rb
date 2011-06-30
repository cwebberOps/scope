class AnswerController < ApplicationController

  layout 'admin'
  before_filter :confirm_logged_in
  before_filter :find_question
  
  def index
    list
    render('list')
  end
  
  def list
    @answers = Answer.order("is_correct DESC")
  end
  
  def new
    @answer = Answer.new(:question_id => @question.id)
  end
  
  def create
    @answer = Answer.new(params[:answer])
    if @answer.save
      flash[:notice] = "Answer Added"
      redirect_to(:action => 'list', :question_id => @answer.question_id)
    else
      render('new')
    end
  end
  
  def edit
    @answer = Answer.find(params[:id])
  end
  
  def update
    @answer = Answer.find(params[:id])
    if @answer.update_attributes(params[:answer])
      flash[:notice] = "Answer Updated"
      redirect_to(:action => 'list', :question_id => @answer.question_id)
    else
      render('new')
    end
  end
  
  def delete
    @answer = Answer.find(params[:id])
  end
  
  def destroy
    @answer = Answer.find(params[:id]).destroy
    flash[:notice] = "Answer Removed"
    redirect_to(:action => 'list', :question_id => @answer.question_id)
  end
  
  private
  
  def find_question
    if params[:question_id]
      @question = Question.find_by_id(params[:question_id])
    end
  end
  
end
