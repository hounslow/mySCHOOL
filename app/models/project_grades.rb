require 'sql_helper'

class ProjectGrades < ActiveRecord::Base
  def ProjectGrades.exists?(student_id, project_name, section_id)
    SqlHelper.exists?("project_grades",
                   {"student_id" => student_id,
                    "project_name" => project_name,
                    "section_id" => section_id })
  end

  def ProjectGrades.project_exists_error
    "That project already exists"
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
