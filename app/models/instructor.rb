require 'sql_helper'

class Instructor < ActiveRecord::Base
# simple existence check
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
  end

# want to view enrollment for section with section_id
# first check is for existence, if no then return error
# if exists then call SqlHelper to retrieve the students that
#  correlate to specified section_id
  def view_enrollment(section_id)
    query = "SELECT student_id, project_name
    FROM enrollments WHERE section_id = #{section_id}"
    if section_id
      query << " AND section_id = #{section_id}"
    end
    query << ";"
    ActiveRecord::Base.connect.exec_query(query)
  end

  def project_query(project_name)
    query = "SELECT * FROM project_grades
    WHERE project_name = #{project_name}"
    if project_name
      query << " AND project_name = #{project_name}"
    end
    query << ";"
    ActiveRecord::Base.connect.exec_query(query)
  end

# This method is going to change the office hours for an instruct
# with a specified instructor_id (??). Check needs to be added
# order to make sure it is a valid instructor
  def edit_office_hours(office_hours, instructor_id)
    ActiveRecord::Base.connect.execute("
    UPDATE instructors
    (SET office_hours = #{office_hours})
    WHERE instructor_id = #{instructor_id}")
    return true
  end

# should this function stay in Instructor or in ProjectGrades?
# First check may not be necessary, but we do it anyway to check
# if the project actually exists to begin with
# case 1: it doesn't so we return an error
# case 2: we insert into project_grades the grade
  def grade(student_id, project_name, section_id, grade)
    project = ProjectGrades.retrieve(student_id, project_name, section_id)
    if project == nil
      raise ProjectGrades.no_project_error
    else
      ActiveRecord::Base.connection.execute("
      INSERT INTO project_grades
      (student_id, project_name, section_id, grade, instructor_id)
      VALUES
      (#{student_id}, '#{project_name}', #{section_id}, #{grade}, #{instructor_id})
      ON DUPLICATE KEY UPDATE grade=#{grade}, instructor_id=#{instructor_id};")
      return true
    end
  end

# simply error message that no instructor exists with specified id
    private
    def Instructor.no_instructor_error(instructor_id)
      "No instructor with ID #{instructor_id} exists"
    end
  end
