class EnrollmentController < ApplicationController
  def list
    @enrollments = Enrollment.all
  end

  def show
    @enrollment = Enrollment.find(params[:id])
    redirect_to @enrollment.url
  end

  def new
    @enrollment = Enrollment.new
  end

  def create
    @enrollment = Enrollment.new(enrollment_param)

    if @enrollment.save
      flash[:enrollment_id] = @enrollment.id
      redirect_to :action => 'list'
    else
      render :action => "new"
    end
  end

  def edit
    @enrollment = Enrollment.find(params[:id])
  end

  def update
   @enrollment = Enrollment.find(params[:id])

   if @enrollment.update_attributes(enrollment_param)
      redirect_to :action => 'show', :id => @enrollment
   else
      #@subjects = Subject.all
      render :action => 'edit'
   end
 end

  def enrollment_param
   params.require(:enrollment).permit(:section_id, :student_id)
 end

 def delete
   Enrollment.find(params[:id]).destroy
   redirect_to :action => 'list'
 end
end
