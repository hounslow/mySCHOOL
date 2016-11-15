module SqlHelper
  def SqlHelper.exists?(table, specifiers)
    return SqlHelper.retrieve(table, specifiers) != nil
  end

  def SqlHelper.insert(table, specifiers)
    ActiveRecord::Base.connection.execute("
    INSERT INTO #{table}
    (#{specifiers.keys.join(',')})
    VALUES
    (#{specifiers.values.map(&:inspect).join(',')});")
    SqlHelper.retrieve(table, specifiers)
  end

  def SqlHelper.retrieve(table, specifiers)
    query = "SELECT * FROM #{table}"
    query << parse_specifiers(specifiers)
    query << ";"
    result = ActiveRecord::Base.connection.exec_query(query).first
    if result != nil
      return table.classify.constantize.new(result)
    else
      return nil
    end
  end

  def SqlHelper.retrieve_all(table, specifiers)
    query = "SELECT * FROM #{table}"
    query << parse_specifiers(specifiers)
    query << ";"
    result = ActiveRecord::Base.connection.exec_query(query)
    if result != nil
      return result.map {|a| table.classify.constantize.new(a)}
    else
      return nil
    end
  end

  def SqlHelper.delete(table, specifiers)
    query = "DELETE FROM #{table}"
    query << parse_specifiers(specifiers)
    query << ";"
    ActiveRecord::Base.connection.exec_query(query)
    return true
  end

  # Does no error checking; use create_project
  def SqlHelper.insert_project(student_id, project_name, section_id)
    ActiveRecord::Base.connection.execute("
    INSERT INTO project_grades
    (project_name, student_id, section_id)
    VALUES
    ('#{project_name}', #{student_id}, #{section_id});")
  end

  def SqlHelper.retrieve_students_from_project(specifiers)
    results = ActiveRecord::Base.connection.exec_query("
      SELECT students.* from students, project_grades
      #{parse_specifiers(specifiers)}
      AND students.student_id = project_grades.student_id;")
    results.map! {|res| Student.new(res)}
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
