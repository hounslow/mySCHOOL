require 'sql_helper'

class ProjectGrades < ActiveRecord::Base
  def ProjectGrades.exists?(student_id, project_name, section_id)
    SqlHelper.exists?("project_grades",
                   {"student_id" => student_id,
                    "project_name" => project_name,
                    "section_id" => section_id })
  end

  def ProjectGrades.retrieve(student_id, project_name, section_id)
    results = SqlHelper.retrieve("project_grades",
                   {"student_id" => student_id,
                    "project_name" => project_name,
                    "section_id" => section_id })
    if results.empty?
      raise ProjectGrades.no_project_error(student_id)
    else
      ProjectGrades.new(results.first)
    end
  end

  def retrieve_students
    results = SqlHelper.retrieve_students_from_project({
      "project_name" => self.project_name,
      "section_id" => self.section_id})
    results.map {|res| Student.new(res)}
  end

  def ProjectGrades.project_exists_error
    "That project already exists"
  end

  def ProjectGrades.no_project_error
    "No such project exists"
  end

  private
  # Does no error checking; use create_project
  def ProjectGrades.insert(student_id, project_name, section_id)
    ActiveRecord::Base.connection.execute("
    INSERT INTO project_grades
    (project_name, student_id, section_id)
    VALUES
    ('#{project_name}', #{student_id}, #{section_id});")
  end
end
