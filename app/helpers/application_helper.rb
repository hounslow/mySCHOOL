module ApplicationHelper
  def exists?(table, specifiers)
    query  = "SELECT * FROM #{table}"
    if(specifiers.length > 0)
      query  << " WHERE "
      specifiers.each do |column, value|
        query << "#{column} = '#{value}' AND "
      end
      # get rid of trailing AND
      query  = query[0..-5]
    end
    query << ";"
    ActiveRecord::Base.connection.exec_query(query).length > 0
  end

  def student_exists?(student_id)
    return exists?("students",
                   {"student_id" => student_id})
  end

  def section_exists?(section_id)
    return exists?("section_teaches",
                   {"section_id" => section_id})
  end

  def enrolled_in?(student_id, section_id)
    return exists?("enrollments",
                   {"student_id" => student_id,
                    "section_id" => section_id})
  end

  def project_exists?(student_id, project_name, section_id)
    return exists?("project_grades",
                   {"student_id" => student_id,
                    "project_name" => project_name,
                    "section_id" => section_id })
  end

  def create_project(student_id, project_name, section_id)
    # Make sure student exists
    if !student_exists?(student_id)
      flash[:error] = no_student_error(student_id)
      return false
    # Make sure student is enrolled in the course
    elsif !enrolled_in?(student_id, section_id)
      flash[:error] = not_enrolled_error(section_id)
      return false
    # Make sure project doesn't exist
    elsif project_exists?(student_id, project_name, section_id )
      flash[:error] = project_exists_error
      return false
    # Everything looks good
    else
      insert_project(student_id, project_name, section_id)
      return true
    end
  end

  def retrieve_grades(student_id, section_id = nil)
    # Make sure student exists
    if !student_exists?(student_id)
      flash[:error] = no_student_error(student_id)
      return false
    else
      grades = select_grades(student_id, section_id)
      if grades.empty?
        flash[:notice] = no_grades_notice(section_id)
      end
      grades
    end
  end

  def enroll(student_id, section_id)
    if !student_exists?(student_id)
      flash[:error] = no_student_error(student_id)
      return false
    elsif !section_exists?(section_id)
      flash[:error] = no_section_error(section_id)
      return false
    elsif enrolled_in?(student_id, section_id)
      flash[:error] = already_enrolled_error(section_id)
      return false
    else
      insert_enrollment(student_id, section_id)
      flash[:notice] = successful_enrollment_notice(section_id)
    end
  end

  private
  def no_student_error(student_id)
    "No student with ID #{student_id} exists"
  end

  def no_section_error(section_id)
    "No section with ID #{section_id} exists"
  end

  def already_enrolled_error(section_id)
    "You are already enrolled in course #{section_id}"
  end

  def not_enrolled_error(section_id)
    "You are not enrolled in course #{section_id}"
  end

  def project_exists_error
    "You already have a project with that name"
  end

  def successful_enrollment_notice(section_id)
    "Successfully enrolled in #{section_id}"
  end

  def no_grades_notice(section_id = nil)
    if section_id
      "No grades for section #{section_id}"
    else
      "No grades"
    end
  end
      
  # Does no error checking; use create_project
  def insert_project(student_id, project_name, section_id)
    ActiveRecord::Base.connection.execute("
    INSERT INTO project_grades
    (project_name, student_id, section_id)
    VALUES
    ('#{project_name}', #{student_id}, #{section_id});")
  end

  # Does no error checking; use enroll
  def insert_enrollment(student_id, section_id)
    ActiveRecord::Base.connection.execute("
    INSERT INTO enrollments
    (student_id, section_id)
    VALUES
    (#{student_id}, #{section_id});")
  end

  # Does no error checking; use retrieve_grades
  def select_grades(student_id, section_id)
    query = "SELECT project_name, section_id, grade, instructor_id
      FROM project_grades WHERE student_id = #{student_id} AND
      grade IS NOT NULL"
    if section_id
      query << " AND section_id = #{section_id}"
    end
    query << ";"
    ActiveRecord::Base.connection.exec_query(query)
  end
end
