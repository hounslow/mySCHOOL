module SqlHelper
  def SqlHelper.exists?(table, specifiers)
    query  = "SELECT * FROM #{table}"
    query << parse_specifiers(specifiers)
    query << ";"
    ActiveRecord::Base.connection.exec_query(query).length > 0
  end

  def SqlHelper.retrieve(table, specifiers)
    query = "SELECT * FROM #{table}"
    query << parse_specifiers(specifiers)
    query << ";"
    ActiveRecord::Base.connection.exec_query(query)
  end

  # Does no error checking; use create_project
  def SqlHelper.insert_project(student_id, project_name, section_id)
    ActiveRecord::Base.connection.execute("
    INSERT INTO project_grades
    (project_name, student_id, section_id)
    VALUES
    ('#{project_name}', #{student_id}, #{section_id});")
  end

  private
  # Parses a set of specifiers {"student_id" => 1, ...} into a WHERE
  # clause "WHERE student_id = 1 AND ..."
  def SqlHelper.parse_specifiers(specifiers)
    result = ""
    if(specifiers.length > 0)
      result << " WHERE "
      specifiers.each do |column, value|
        result << "#{column} = '#{value}' AND "
      end
      # get rid of trailing AND
      result  = result[0..-5]
    end
  end
end
