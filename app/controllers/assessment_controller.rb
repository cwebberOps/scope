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
    @errors = []
    if @file.original_filename =~ /.xlsx/
      @excel = Excelx.new(@file.tempfile.path, false, :warning)
    else
      @excel = Excel.new(@file.tempfile.path, false, :warning)
    end
    
    @excel.default_sheet = @excel.sheets.first
    # General Idea:
    # for each line, add the question
    # Add each answer
    # in the complete, remove the other ones.
    2.upto(@excel.last_row) do |line|
      
      if standard_subject = StandardSubject.find_by_designation(@excel.cell(line, 'B').to_s)
        if standard = standard_subject.standards.find_by_designation(@excel.cell(line, 'C').to_i.to_s) # The to_i is a hack for now
          if sub_standard = standard.sub_standards.find_by_designation(@excel.cell(line, 'D').to_s)
          
            question = Question.new(
              :assessment_id => @assessment.id,
              :sub_standard_id => sub_standard.id,
              :is_verified => false,
              :value => @excel.cell(line, 'A')
            )            
            if question.save
              # Process the correct answer
              answer_1 = Answer.new(
                :question_id => question.id,
                :value => @excel.cell(line, 'E').to_s,
                :is_correct => true
              )
              answer_1.save
              if @excel.cell(line, 'F')
                answer_2 = Answer.new(
                  :question_id => question.id,
                  :value => @excel.cell(line, 'F').to_s
                )
                answer_2.save
              end
              if @excel.cell(line, 'G')
                answer_3 = Answer.new(
                  :question_id => question.id,
                  :value => @excel.cell(line, 'G').to_s
                )
                answer_3.save
              end
              if @excel.cell(line, 'H')
                answer_4 = Answer.new(
                  :question_id => question.id,
                  :value => @excel.cell(line, 'H').to_s
                )
                answer_4.save
              end
            else
              @errors << "'#{@excel.cell(line, 'A')}' Was not imported."
            end
            
          else
            @errors << "#{@excel.cell(line, 'B')}#{@excel.cell(line, 'C')}#{@excel.cell(line, 'D')} is not a valid Sub-Standard designation."
          end
        else
          @errors << "#{@excel.cell(line, 'B')}#{@excel.cell(line, 'C')} is not a valid Standard designation."
        end
      else
        @errors << "#{@excel.cell(line, 'B')} is not a valid Standard Subject designation."
      end
    end
    @questions = Question.where(:assessment_id => @assessment.id)
  end

  def complete

    question_ids = params[:question_id]
    question_ids.each do |question_id|
      question = Question.find_by_id(question_id)
      question.update_attribute(:is_verified, true)
    end

    redirect_to(:action => 'list')

    end

  
end
