require 'test_helper'

class ProjectGradesTest < ActionView::TestCase
  test "project_grades_exists? true" do
    assert ProjectGrades.exists?(1,"Assignment 1",80)
  end

  test "project_grades_exists? false" do
    assert_not ProjectGrades.exists?(2,'Assignment 1',80)
    assert_not ProjectGrades.exists?(1,'Assignment 5',80)
    assert_not ProjectGrades.exists?(1,'Assignment 1',78)
  end

  test "project_grades_retrieve_students" do
    res = ProjectGrades.retrieve(1,"Assignment 1",80).retrieve_students
    assert_includes res, Student.retrieve(1)
    assert_not_includes res, Student.retrieve(2)
    assert_includes res, Student.retrieve(3)
    assert_not_includes res, Student.retrieve(4)
    assert_not_includes res, Student.retrieve(5)
  end
end
