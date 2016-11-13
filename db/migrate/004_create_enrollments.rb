class CreateEnrollments < ActiveRecord::Migration[5.0]
  def change
    execute <<-SQL
      DROP TABLE IF EXISTS enrollments;
    SQL
    execute <<-SQL
      CREATE TABLE enrollments (
      section_id INTEGER NOT NULL,
      student_id INTEGER NOT NULL,
      PRIMARY KEY (section_id, student_id),
      FOREIGN KEY (section_id) REFERENCES section_teaches(section_id) ON DELETE CASCADE,
      FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE);
    SQL
  end
end
