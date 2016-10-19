class CreateEnrollments < ActiveRecord::Migration[5.0]
  def change
    execute <<-SQL
      CREATE TABLE enrollments (
      section_id INTEGER NOT NULL,
      student_id INTEGER NOT NULL,
      PRIMARY KEY (section_id, student_id),
      FOREIGN KEY (section_id) REFERENCES section_teaches(section_id),
      FOREIGN KEY (student_id) REFERENCES students(student_id));
    SQL
  end
end
