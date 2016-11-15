require 'sql_helper'

class ProjectGrade < ActiveRecord::Base
  def ProjectGrade.exists?(student_id, project_name, section_id)
    SqlHelper.exists?("project_grades",
                   {"student_id" => student_id,
                    "project_name" => project_name,
                    "section_id" => section_id })
  end

  def ProjectGrade.retrieve(student_id, project_name, section_id)
    SqlHelper.retrieve("project_grades",
                   {"student_id" => student_id,
                    "project_name" => project_name,
                    "section_id" => section_id })
  end

  def ProjectGrade.create(student_id, project_name, section_id)
      return SqlHelper.insert("project_grades",
                    {"student_id" => student_id,
                     "project_name" => project_name,
                     "section_id" => section_id})
  end

  def delete
    SqlHelper.delete("project_grades",
          {"student_id" => student_id,
           "project_name" => project_name,
           "section_id" => section_id})
  end

  def retrieve_students
    SqlHelper.retrieve_students_from_project({
      "project_name" => self.project_name,
      "section_id" => self.section_id})
  end

  def ProjectGrade.project_exists_error
    "That project already exists"
  end

  def ProjectGrade.no_project_error
    "No such project exists"
  end
end
