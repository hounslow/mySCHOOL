class CreateOfficeHours < ActiveRecord::Migration[5.0]
  def change
    execute <<-SQL
      CREATE TABLE office_hours (
      start DATE NOT NULL,
      end DATE NOT NULL,
      day TINYINT NOT NULL,
      instructor_id INTEGER NOT NULL,
      PRIMARY KEY (start, end, day, instructor_id),
      FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id));
    SQL
  end
end
