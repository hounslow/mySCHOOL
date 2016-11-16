class ProjectGradeController < ApplicationController
  def list
    @project_grades = ProjectGrade.all
  end

  def show
    @project_grades = ProjectGrade.find(params[:id])
    redirect_to @project_grades.url
  end

  def new
    @project_grades = ProjectGrade.new
  end

  def create
    @project_grades = ProjectGrade.new(project_grades_param)

    if @project_grades.save
      flash[:project_grades_id] = @project_grades.id
      redirect_to :action => 'list'
    else
      render :action => "new"
    end
  end

  def edit
    @project_grades = ProjectGrade.find(params[:id])
  end

  def update
   @project_grades = ProjectGrade.find(params[:id])

   if @project_grades.update_attributes(project_grades_param)
      redirect_to :action => 'show', :id => @project_grades
   else
      #@subjects = Subject.all
      render :action => 'edit'
   end
 end

  def project_grades_param
   params.require(:project_grades).permit(:project_name, :student_id, :section_id, :grade, :instructor_id)
 end

 def delete
   ProjectGrade.find(params[:id]).destroy
   redirect_to :action => 'list'
 end
end
