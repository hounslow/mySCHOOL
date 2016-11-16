class SectionTeachController < ApplicationController
  def list
    @section_teaches = SectionTeach.all
  end

  def show
    @section_teaches = SectionTeach.find(params[:id])
    redirect_to @section_teaches.url
  end

  def new
    @section_teaches = SectionTeach.new
  end

  def create
    @section_teaches = SectionTeach.new(section_teaches_param)

    if @section_teaches.save
      flash[:section_teaches_id] = @section_teaches.id
      redirect_to :action => 'list'
    else
      render :action => "new"
    end
  end

  def edit
    @section_teaches = SectionTeach.find(params[:id])
  end

  def update
   @section_teaches = SectionTeach.find(params[:id])

   if @section_teaches.update_attributes(section_teaches_param
)
      redirect_to :action => 'show', :id => @section_teaches
   else
      #@subjects = Subject.all
      render :action => 'edit'
   end
 end

  def section_teaches_param
   params.require(:section_teaches).permit(:section_id, :section_name, :instructor_id)
 end

 def delete
   SectionTeach.find(params[:id]).destroy
   redirect_to :action => 'list'
 end
end
