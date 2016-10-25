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

  def registered_in?(student_id, section_id)
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
      flash[:error] = "No student with ID #{student_id} exists"
      return false
    # Make sure student is registered in the course
    elsif !registered_in?(student_id, section_id)
      flash[:error] = "You are not registered in course #{section_id}"
      return false
    # Make sure project doesn't exist
    elsif project_exists?(student_id, project_name, section_id )
      flash[:error] = "You already have a project with that name"
      return false
    # Everything looks good
    else
      insert_project(student_id, project_name, section_id)
      return true
    end
  end

  private
  # Does no error checking; use create_project
  def insert_project(student_id, project_name, section_id)
    ActiveRecord::Base.connection.execute("
    INSERT INTO project_grades
    (project_name, student_id, section_id)
    VALUES
    ('#{project_name}', #{student_id}, #{section_id});")
  end
end
