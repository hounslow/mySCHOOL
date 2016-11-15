require 'test_helper'

class InstructorTest < ActionView::TestCase
  test "instructor exists" do
    assert Instructor.exists?(1)
    assert_not Instructor.exists?(7)
  end

  test "instructor retrieve" do
    instructor = Instructor.retrieve(1)
    assert_equal instructor.class.name, "Instructor"
    assert_equal instructor.instructor_name, "Marvin Gates"
    assert_equal instructor.instructor_email, "mgates@ubc.ca"
  end

  test "instructor register/unregister true" do
    assert instructor = Instructor.register(10,"Bob", "bob@bob.com")
    assert instructor.unregister
    assert_not Instructor.exists?(10)
  end

  test "instructor grade true" do
    assert Instructor.retrieve(3).grade(1, 'Assignment 1', 80, 55)
    project = ProjectGrade.retrieve(1, 'Assignment 1', 80)
    assert_equal project.grade, 55
    assert_equal project.instructor_id, 3
  end
end
