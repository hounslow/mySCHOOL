class CreateSectionTeaches < ActiveRecord::Migration[5.0]
  def change
    execute <<-SQL
      DROP TABLE IF EXISTS section_teaches;
    SQL
    execute <<-SQL
      CREATE TABLE section_teaches (
      section_id INTEGER AUTO_INCREMENT PRIMARY KEY,
      section_name VARCHAR(30),
      instructor_id INTEGER NOT NULL,
      FOREIGN KEY (instructor_id) REFERENCES instructors (instructor_id) ON DELETE CASCADE);
    SQL
  end
end
