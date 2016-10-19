class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    execute <<-SQL
      CREATE TABLE students (
      student_id INTEGER AUTO_INCREMENT PRIMARY KEY,
      student_name VARCHAR(30),
      student_email VARCHAR(30));
    SQL
  end
end
