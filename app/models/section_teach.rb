require 'sql_helper'

class SectionTeach < ActiveRecord::Base
  def SectionTeach.exists?(section_id)
    return SqlHelper.exists?("section_teaches",
                   {"section_id" => section_id})
  end

  def SectionTeach.create(section_id, section_name, instructor_id)
    if SectionTeach.exists?(section_id)
      raise section_exists_error(section_id)
    elsif !Instructor.exists?(instructor_id)
      raise Instructor.no_instructor_error(instructor_id)
    else
      return SqlHelper.insert("section_teaches",
         {"section_id" => section_id,
          "section_name" => section_name,
          "instructor_id" => instructor_id})
    end
  end

  def SectionTeach.retrieve(section_id)
    SqlHelper.retrieve("section_teaches",
                       {"section_id" => section_id})
  end

  def delete
    SqlHelper.delete("section_teaches",
          {"section_id" => section_id})
    return !SectionTeach.exists?(section_id)
  end

  private
  def SectionTeach.no_section_error(section_id)
    "No section with ID #{section_id} exists"
  end

  def SectionTeach.section_exists_error(section_id)
    "SectionTeach #{section_id} already exists"
  end

end
