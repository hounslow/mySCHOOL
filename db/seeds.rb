ActiveRecord::Base.connection.execute("DELETE FROM instructors");
ActiveRecord::Base.connection.execute("
INSERT IGNORE INTO instructors
(instructor_id, instructor_name, instructor_email, is_professor)
VALUES
(1, 'Marvin Gates', 'mgates@ubc.ca', 1);")
ActiveRecord::Base.connection.execute("
INSERT IGNORE INTO instructors
(instructor_id, instructor_name, instructor_email, is_professor)
VALUES
(2, 'Cintia Rocha', 'crocha@ubc.ca', 1);")
ActiveRecord::Base.connection.execute("
INSERT IGNORE INTO instructors
(instructor_id, instructor_name, instructor_email, is_professor)
VALUES
(3, 'Paula Marx', 'paula_marx@gmail.com', 0);")
ActiveRecord::Base.connection.execute("
INSERT IGNORE INTO instructors
(instructor_id, instructor_name, instructor_email, is_professor)
VALUES
(4, 'Darrell Williams', 'dwills@aol.com', 0);")
ActiveRecord::Base.connection.execute("
INSERT IGNORE INTO instructors
(instructor_id, instructor_name, instructor_email, is_professor)
VALUES
(5, 'Yu Li', 'yu@yu.com', 0);")

ActiveRecord::Base.connection.execute("
INSERT IGNORE INTO section_teaches
(section_id, section_name, instructor_id)
VALUES (80, 'CPSC 304', 1);")

ActiveRecord::Base.connection.execute("
INSERT IGNORE INTO section_teaches
(section_id, section_name, instructor_id)
VALUES (78, 'CPSC 305', 1);")

ActiveRecord::Base.connection.execute("
INSERT IGNORE INTO section_teaches
(section_id, section_name, instructor_id)
VALUES (77, 'CPSC 306', 2);")

ActiveRecord::Base.connection.execute("
INSERT IGNORE INTO section_teaches
(section_id, section_name, instructor_id)
VALUES (2, 'CPSC 307', 2);")

ActiveRecord::Base.connection.execute("
INSERT IGNORE INTO section_teaches
(section_id, section_name, instructor_id)
VALUES (1, 'CPSC 304', 1);")

ActiveRecord::Base.connection.execute("
INSERT IGNORE INTO students
(student_id, student_name, student_email)
VALUES (1, 'George', 'george@mail.com');")

ActiveRecord::Base.connection.execute("
INSERT IGNORE INTO students
(student_id, student_name, student_email)
VALUES (2, 'Ben', 'ben@mail.com');")

ActiveRecord::Base.connection.execute("
INSERT IGNORE INTO students
(student_id, student_name, student_email)
VALUES (3, 'Bob', 'bob@mail.com');")

ActiveRecord::Base.connection.execute("
INSERT IGNORE INTO students
(student_id, student_name, student_email)
VALUES (4, 'Morty', 'morty@mail.com');")

ActiveRecord::Base.connection.execute("
INSERT IGNORE INTO students
(student_id, student_name, student_email)
VALUES (5, 'Rick', 'rick@mail.com');")

ActiveRecord::Base.connection.execute("
INSERT IGNORE INTO enrollments
(section_id, student_id)
VALUES (80, 3);")

ActiveRecord::Base.connection.execute("
INSERT IGNORE INTO enrollments
(section_id, student_id)
VALUES (78, 3);")

ActiveRecord::Base.connection.execute("
INSERT IGNORE INTO enrollments
(section_id, student_id)
VALUES (77, 1);")

ActiveRecord::Base.connection.execute("
INSERT IGNORE INTO enrollments
(section_id, student_id)
VALUES (2, 2);")

ActiveRecord::Base.connection.execute("
INSERT IGNORE INTO enrollments
(section_id, student_id)
VALUES (80, 1);")

ActiveRecord::Base.connection.execute("
INSERT IGNORE INTO office_hours
(start, end, day, instructor_id) VALUES
('10:00', '11:00', 1, 1);")

ActiveRecord::Base.connection.execute("
INSERT IGNORE INTO office_hours
(start, end, day, instructor_id) VALUES
('10:00', '11:00', 1, 2);")

ActiveRecord::Base.connection.execute("
INSERT IGNORE INTO office_hours
(start, end, day, instructor_id) VALUES
('10:00', '11:00', 3, 1);")

ActiveRecord::Base.connection.execute("
INSERT IGNORE INTO office_hours
(start, end, day, instructor_id) VALUES
('14:30', '15:30', 5, 3);")

ActiveRecord::Base.connection.execute("
INSERT IGNORE INTO office_hours
(start, end, day, instructor_id) VALUES
('12:30', '13:30', 4, 4);")

ActiveRecord::Base.connection.execute("
INSERT IGNORE INTO project_grades
(project_name, student_id, section_id) VALUES
('Assignment 1', 1, 80);")

ActiveRecord::Base.connection.execute("
INSERT IGNORE INTO project_grades
(project_name, student_id, section_id) VALUES
('Assignment 1', 3, 80);")

ActiveRecord::Base.connection.execute("
INSERT IGNORE INTO project_grades
(project_name, student_id, section_id,
  grade, instructor_id) VALUES
('Tutorial 1', 3, 78, 80, 5);")

ActiveRecord::Base.connection.execute("
INSERT IGNORE INTO project_grades
(project_name, student_id, section_id,
  grade, instructor_id) VALUES
('Tutorial 2', 3, 78, 68, 5);")

ActiveRecord::Base.connection.execute("
INSERT IGNORE INTO project_grades
(project_name, student_id, section_id,
  grade, instructor_id) VALUES
('Assignment 2', 1, 80, 77, 4);")

# Test
#ActiveRecord::Base.connection.exec_query("
#SELECT instructor_name, instructor_email
#FROM instructors
#WHERE NOT is_professor;").each {|data| print "#{data}\n"}
#
