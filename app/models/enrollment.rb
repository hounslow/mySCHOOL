require 'sql_helper'

class Enrollment < ActiveRecord::Base
  def Enrollment.exists?(student_id, section_id)
    return SqlHelper.exists?("enrollments",
                   {"student_id" => student_id,
                    "section_id" => section_id})
  end

  def Enrollment.enroll(student_id, section_id)
    if !Section.exists?(section_id)
      raise Section.no_section_error(section_id)
    elsif Enrollment.exists?(student_id, section_id)
      raise already_enrolled_error(section_id)
    else
      return Enrollment.insert(student_id, section_id)
    end
  end

  private
  # Does no error checking; use enroll
  def Enrollment.insert(student_id, section_id)
    ActiveRecord::Base.connection.execute("
    INSERT INTO enrollments
    (student_id, section_id)
    VALUES
    (#{student_id}, #{section_id});")
    return true
  end

  def Enrollment.already_enrolled_error(section_id)
    "You are already enrolled in course #{section_id}"
  end

# no students enrolled
  def Enrollment.no_student_error(section_id)
    "No students enrolled in course #{section_id}"
  end
end
