class SqlHelper 
  def SqlHelper.exists?(table, specifiers)
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
end
