require 'sql_helper'

class Instructor <ActiveRecord::Base
# simply existence check
  def Instructor.exists?(instructor_id)
    return SqlHelper.exists?("instructors",
    {"instructor_id" => instructor_id})
  end

# retrieve the instructor using the instructor_id
# if no instruct exists we call no_instructor_error
# otherwise call new
  def Instructor.retrieve(instructor_id)
    results = SqlHelper.retrieve("instructors",
    {"instructor_id" => instructor_id})
    if results.empty?
      raise Instructor.no_instructor_error(instructor_id)
    else
      Instructor.new(results.first)
    end

# want to view enrollment for section with section_id
# first check is for existence, if no then return error
# if exists then call SqlHelper to retrieve the students that
#  correlate to specified section_id
TODO:
  def Instructor.view_enrollment(section_id)
    if !Section.exists?(section_id)
      raise Section.no_section_error(section_id)
    elseif Section.exists?(section_id)
    results = SqlHelper.retrieve("students",
        {"student_id" => student_id,
          "")
          return results
        end

# should this function stay in Instructor or in ProjectGrades?
# First check may not be necessary, but we do it anyway to check
# if the project actually exists to begin with
# case 1: it doesn't so we return an error
# case 2: we insert into project_grades the grade
  def Instructor.grade(instructor_id, student_id, project_name, grade)
    if !ProjectGrades.exists?(student_id, project_name, section_id)
      raise ProjectGrades.no_project_error
    elseif ProjectGrades.exists?(student_id, project_name, section_id)
      ActiveRecord::Base.connection.execute("
      INSERT INTO project_grades
      (student_id, project_name, section_id, grade)
      VALUES
      {#{student_id}, #{project_name}, #{section_id}, #{grade});")
      return true
    end

# simply error message that no instructor exists with specified id
    private
    def Instructor.no_instructor_error(instructor_id)
      "No instructor with ID #{instructor_id} exists"
    end
  end
