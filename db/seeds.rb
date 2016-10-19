ActiveRecord::Base.connection.execute("DELETE FROM instructors");
ActiveRecord::Base.connection.execute("
INSERT INTO instructors
(instructor_id, instructor_name, instructor_email, is_professor)
VALUES
(1, 'Marvin Gates', 'mgates@ubc.ca', 1);")
ActiveRecord::Base.connection.execute("
INSERT INTO instructors
(instructor_id, instructor_name, instructor_email, is_professor)
VALUES
(2, 'Cintia Rocha', 'crocha@ubc.ca', 1);")
ActiveRecord::Base.connection.execute("
INSERT INTO instructors
(instructor_id, instructor_name, instructor_email, is_professor)
VALUES
(3, 'Paula Marx', 'paula_marx@gmail.com', 0);")
ActiveRecord::Base.connection.execute("
INSERT INTO instructors
(instructor_id, instructor_name, instructor_email, is_professor)
VALUES
(4, 'Darrell Williams', 'dwills@aol.com', 0);")
ActiveRecord::Base.connection.execute("
INSERT INTO instructors
(instructor_id, instructor_name, instructor_email, is_professor)
VALUES
(5, 'Yu Li', 'yu@yu.com', 0);")

ActiveRecord::Base.connection.exec_query("
SELECT instructor_name, instructor_email
FROM instructors
WHERE NOT is_professor;").each {|data| print "#{data}\n"}
