class StudentController < ApplicationController

  layout 'admin'
  before_filter :confirm_logged_in

  def index
    list
    render('list')
  end

  def list
    @students = Student.where(:is_enrolled => 1).sorted
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(params[:student])
    if @student.save
      flash[:notice] = 'Student created.'
      redirect_to(:action => 'list')
    else
      render("new")
    end
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    if @student.update_attributes(params[:student])
      flash[:notice] = "Student updated."
      redirect_to(:action => "list")
    else
      render("edit")
    end
  end

  def delete
    @student = Student.find(params[:id])
  end

  def destroy
    @student.Student.find(params[:id])
    @student.is_enrolled = 0
    flash[:notice] = "Student deleted."
    redirect_to(:action => "list")
  end

  def import
    
  end
  
  def verify
    @file = params[:file]
    @errors = []
    if @file.original_filename =~ /.xlsx/
      @excel = Excelx.new(@file.tempfile.path, false, :warning)
    else
      @excel = Excel.new(@file.tempfile.path, false, :warning)
    end
    
    @excel.default_sheet = @excel.sheets.first
    # General Idea:
    # for each line, check to see if the student exists
    # If the exist, set status to 1, otherwise add and set status to 2
    # Mark all that were not found with a status of 3
    2.upto(@excel.last_row) do |line|
      
      if @student = Student.find_by_student_num(@excel.cell(line, 'A').to_s)
        if @student.is_enrolled == 0
          @student.import_status = 4
        else
          @student.import_status = 1
        end

      else
        @student = Student.new(
          :student_num => @excel.cell(line, 'A').to_i,
          :last_name => @excel.cell(line, 'B'),
          :first_name => @excel.cell(line, 'C'),
          :grad_year => @excel.cell(line, 'D').to_i,
          :can_log_in => false,
          :import_status => 2
        )
      end
      if !(@student.save)
        @errors << "#{@excel.cell(line, 'A').to_s}, #{@excel.cell(line, 'B')}, #{@excel.cell(line, 'C')}, #{@excel.cell(line, 'D').to_s}"
      end
    end
    @other_students = Student.where(:import_status => 0).where(:is_enrolled => 1)
    @other_students.each do |student|
      student.import_status = 3
      student.save
    end
    
    @unchanged_students = Student.where(:import_status => 1)
    @new_students = Student.where(:import_status => 2)
    @old_students = Student.where(:import_status => 3)
    @prev_students = Student.where(:import_status => 4)

  end
  
  def complete
    
    unchanged_students = Student.where(:import_status => 1)
    unchanged_students.each do |student|
      student.import_status = 0
      student.save
    end
    
    if params[:new_student_id]
      new_student_ids = params[:new_student_id]
      new_student_ids.each do |new_student_id|
        new_student = Student.find_by_id(new_student_id)
        new_student.import_status = 0
        new_student.save
      end
    end
    
    if params[:old_student_id]
      old_student_ids = params[:old_student_id]
      old_student_ids.each do |old_student_id|
        old_student = Student.find_by_id(old_student_id)
        old_student.import_status = 0
        old_student.is_enrolled = 0
        old_student.save
      end
    end

    if params[:prev_student_id]
      prev_student_ids = params[:prev_student_id]
      prev_student_ids.each do |prev_student_id|
        prev_student = Student.find_by_id(prev_student_id)
        prev_student.import_status = 0
        prev_student.is_enrolled = 1
        prev_student.save
      end
    end
    
    redirect_to(:action => 'list')
  end
end
