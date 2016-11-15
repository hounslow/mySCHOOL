require 'sql_helper'

class Student < ActiveRecord::Base
  def Student.exists?(student_id)
    SqlHelper.exists?("students", {"student_id" => student_id})
  end

  def Student.retrieve(student_id)
    result = SqlHelper.retrieve("students", {"student_id" => student_id})
    if result == nil
      raise Student.no_student_error(student_id)
    else
      result
    end
  end

  def enrolled_in?(section_id)
    return Enrollment.exists?(self.id, section_id)
  end

  def create_project(project_name, section_id)
    if !enrolled_in?(section_id)
      raise not_registered_error(section_id)
    # Make sure project doesn't exist
    elsif ProjectGrade.exists?(student_id, project_name, section_id)
      raise ProjectGrade.project_exists_error
    # Everything looks good
    else
      SqlHelper.insert_project(student_id, project_name, section_id)
      return true
    end
  end

  def grades(section_id = nil)
    Student.select_grades(student_id, section_id)
  end

  def projects
    Student.select_projects(student_id)
  end

  private
  def Student.no_student_error(student_id)
    "No student with ID #{student_id} exists"
  end

  def Student.not_enrolled_error(section_id)
    "You are not registered in course #{section_id}"
  end

  def Student.no_grades_notice(section_id = nil)
    if section_id
      "No grades for section #{section_id}"
    else
      "No grades"
    end
  end

   # Does no error checking; use retrieve_grades
  def Student.select_grades(student_id, section_id)
    query = "SELECT project_name, section_id, grade, instructor_id
      FROM project_grades WHERE student_id = #{student_id} AND
      grade IS NOT NULL"
    if section_id
      query << " AND section_id = #{section_id}"
    end
    query << ";"
    ActiveRecord::Base.connection.exec_query(query)
  end

  def Student.select_projects(student_id)
    SqlHelper.retrieve_all("project_grades",{
      "student_id" => student_id})
  end
end
