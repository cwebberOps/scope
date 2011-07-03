class StandardSubjectController < ApplicationController

  layout 'admin'
  before_filter :confirm_logged_in

  def index
    list
    render('list')
  end

  def new
    @standard_subject = StandardSubject.new
  end

  def list
    @standard_subjects = StandardSubject.order("name ASC")
  end

  def edit
    @standard_subject = StandardSubject.find(params[:id])
  end

  def update
    @standard_subject = StandardSubject.find(params[:id])
    if @standard_subject.update_attributes(params[:standard_subject])
      flash[:notice] = "Standard Subject Updated"
      redirect_to(:action => "list")
    else
      render("edit")
    end
  end

  def create
    @standard_subject = StandardSubject.new(params[:standard_subject])
    if @standard_subject.save
      flash[:notice] = "Standard Subject Created"
      redirect_to(:action => 'list')
    else
      render("new")
    end
  end

  def delete
    @standard_subject = StandardSubject.find(params[:id])
  end

  def destroy
    StandardSubject.find(params[:id]).destroy
    flash[:notice] = "Standard Subject deleted."
    redirect_to(:action => "list")
  end

  def import
    @standard_subject = StandardSubject.find(params[:id])
  end
  
  def verify
    @standard_subject = StandardSubject.find(params[:id])
    @file = params[:file]
    
    if @file.original_filename =~ /.xlsx/
      @excel = Excelx.new(@file.tempfile.path, false, :warning)
    else
      @excel = Excel.new(@file.tempfile.path, false, :warning)
    end
    
    @excel.default_sheet = @excel.sheets.first
    @revist_list = []
    @bad_list = []
    
    2.upto(@excel.last_row) do |line| # Process each of the lines
      if @excel.cell(line, 'B') == nil && !(Standard.find_by_designation_and_standard_subject_id(@excel.cell(line, 'A'), @standard_subject.id)) # Make sure it is a standard and that the standard doesnt exist
        standard = Standard.new(
          :standard_subject_id => @standard_subject.id,
          :designation => @excel.cell(line, 'A').to_i, # I am sure this is going to break things... 
          :value => @excel.cell(line, 'C'),
          :session_id => session[:id],
          :is_verified => false
        )
        if standard.save 
          else
            flash[:notice] += "#{@excel.cell(line,'A')} falied to import. \n"
          next
        end
      else
        standard = Standard.find_by_designation_and_standard_subject_id(@excel.cell(line, 'A'), @standard_subject.id) # Find the standard associated with the line
        if standard
          if !(SubStandard.find_by_designation_and_standard_id(@excel.cell(line, 'B'), standard.id)) # Make sure the sub_standard doesnt already exist
            sub_standard = SubStandard.new(
              :standard_id => standard.id,
              :designation => @excel.cell(line,'B'),
              :value => @excel.cell(line, 'C'),
              :session_id => session[:id],
              :is_verified => false
            )
            if sub_standard.save
              next
            else
              flash[:notice] += "#{@excel.cell(line,'B')} falied to import. \n"
            end
          end
        else
          @revisit_list << line # if we were not able to actually address this because the standard didnt exist, revist the line
        end
      end      
    end
    
    if @revisit_list
      @revisit_list.each do |line| # Go through the lines that we determined the standard didnt already exist for.
        standard = Standard.find_by_designation_and_standard_subject_id(@excel.cell(line, 'A'), @standard_subject.id)
        if standard
          if !(SubStandard.find_by_designation_and_standard_id(@excel.cell(line, 'B'), standard.id))
            sub_standard = SubStandard.new(
              :standard_id => standard.id,
              :designation => @excel.cell(line,'B'),
              :value => @excel.cell(line, 'C'),
              :session_id => session[:id],
              :is_verified => false
            )
            if sub_standard.save
              next
            end
          end
        else
          @bad_list << line
        end
      end
    end
    @standards = Standard.where(:standard_subject_id => @standard_subject.id)
  end
  
  def complete

    standard_ids = params[:standard_id]
    standard_ids.each do |standard_id|
      standard = Standard.find_by_id(standard_id)
      standard.update_attribute(:is_verified, true)
    end

    sub_standard_ids = params[:sub_standard_id]
    sub_standard_ids.each do |sub_standard_id|
      sub_standard = SubStandard.find_by_id(sub_standard_id)
      sub_standard.update_attribute(:is_verified, true)
    end

    redirect_to(:action => 'list')
  end
end

