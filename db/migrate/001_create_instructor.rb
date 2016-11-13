class CreateInstructor < ActiveRecord::Migration[5.0]
  def change
    execute <<-SQL
      DROP TABLE IF EXISTS instructors;
      SQL
    execute <<-SQL
      CREATE TABLE instructors (
      instructor_id INTEGER AUTO_INCREMENT PRIMARY KEY,
      instructor_name VARCHAR(30),
      instructor_email VARCHAR(30),
      is_professor BOOLEAN);
    SQL
  end
end
