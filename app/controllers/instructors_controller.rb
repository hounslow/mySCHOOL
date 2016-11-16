class InstructorsController < ApplicationController

  def list
    @instructors = Instructor.all
  end

  def show
    @instructor = Instructor.find(params[:id])
    redirect_to @instructor.url
  end

  def new
    @instructor = Instructor.new
  end

  def create
    @instructor = Instructor.new(instructor_param)

    if @instructor.save
      flash[:instructor_id] = @instructor.id
      redirect_to :action => 'list'
    else
      render :action => "new"
    end
  end

  def edit
    @instructor = Instructor.find(params[:id])
  end

  def update
   @instructor = Instructor.find(params[:id])

   if @instructor.update_attributes(instructor_param)
      redirect_to :action => 'show', :id => @instructor
   else
      #@subjects = Subject.all
      render :action => 'edit'
   end
 end

  def instructor_param
   params.require(:instructor).permit(:instructor_id, :instructor_name, :instructor_email, :is_professor)
 end

 def delete
   Instructor.find(params[:id]).destroy
   redirect_to :action => 'list'
 end
end
