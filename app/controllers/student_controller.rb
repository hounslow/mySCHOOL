class StudentController < ApplicationController
  def list
    @students = Student.all
  end

  def show
    @students = Student.find(params[:id])
    redirect_to @students.url
  end

  def new
    @students = Student.new
  end

  def create
    @students = Student.new(students_param)

    if @students.save
      flash[:students_id] = @students.id
      redirect_to :action => 'list'
    else
      render :action => "new"
    end
  end

  def edit
    @students = Student.find(params[:id])
  end

  def update
   @students = Student.find(params[:id])

   if @students.update_attributes(students_param)
      redirect_to :action => 'show', :id => @students
   else
      #@subjects = Subject.all
      render :action => 'edit'
   end
 end

  def students_param
   params.require(:students).permit(:student_id, :student_name, :student_email)
 end

 def delete
   Student.find(params[:id]).destroy
   redirect_to :action => 'list'
 end
end
