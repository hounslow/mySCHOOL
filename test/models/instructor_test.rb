require 'test_helper'

class InstructorTest < ActionView::TestCase
  test "grade true" do
    assert Instructor.retrieve(3).grade(1, 'Assignment 1', 80, 55)
    project = ProjectGrades.retrieve(1, 'Assignment 1', 80)
    assert_equal project.grade, 55
    assert_equal project.instructor_id, 3
  end
end
