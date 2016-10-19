class CreateProjectGrades < ActiveRecord::Migration[5.0]
  def change
    execute <<-SQL
      CREATE TABLE project_grades (
      project_name VARCHAR(30) NOT NULL,
      student_id INTEGER NOT NULL,
      section_id INTEGER NOT NULL,
      grade INTEGER,
      instructor_id INTEGER,
      PRIMARY KEY (project_name, student_id, section_id),
      FOREIGN KEY (student_id) REFERENCES students(student_id),
      FOREIGN KEY (section_id) REFERENCES section_teaches(section_id),
      FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id));
    SQL
  end
end
