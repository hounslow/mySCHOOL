require 'sql_helper'

class Enrollment < ActiveRecord::Base
  def Enrollment.exists?(student_id, section_id)
    return SqlHelper.exists?("enrollments",
                   {"student_id" => student_id,
                    "section_id" => section_id})
  end

  def Enrollment.enroll(student_id, section_id)
    if !SectionTeach.exists?(section_id)
      raise SectionTeach.no_section_error(section_id)
    elsif Enrollment.exists?(student_id, section_id)
      raise already_enrolled_error(section_id)
    else
      return SqlHelper.insert("enrollments",
                    {"student_id" => student_id,
                     "section_id" => section_id})
    end
  end

  def Enrollment.retrieve(student_id, section_id)
    SqlHelper.retrieve("enrollments",
                { "student_id" => student_id,
                  "section_id" => section_id})
  end

  def unenroll
    SqlHelper.delete("enrollments",
          {"student_id" => student_id,
           "section_id" => section_id})
    return !Enrollment.exists?(student_id, section_id)
  end

  def Enrollment.already_enrolled_error(section_id)
    "You are already enrolled in course #{section_id}"
  end

# no students enrolled
  def Enrollment.no_student_error(section_id)
    "No students enrolled in course #{section_id}"
  end

  def Enrollment.no_enrollment_error(student_id, section_id)
    "Student #{student_id} is not enrolled in section #{section_id}"
  end
end
