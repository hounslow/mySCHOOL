class CreateOfficeHours < ActiveRecord::Migration[5.0]
  def change
    execute <<-SQL
      CREATE TABLE office_hours (
      start TIME NOT NULL,
      end TIME NOT NULL,
      day TINYINT NOT NULL,
      instructor_id INTEGER NOT NULL,
      PRIMARY KEY (start, end, day, instructor_id),
      FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id));
    SQL
  end
end
