require 'test_helper'

class ProjectGradeTest < ActionView::TestCase
  test "project_grade exists?" do
    assert ProjectGrade.exists?(1,"Assignment 1",80)
    assert_not ProjectGrade.exists?(2,'Assignment 1',80)
    assert_not ProjectGrade.exists?(1,'Assignment 5',80)
    assert_not ProjectGrade.exists?(1,'Assignment 1',78)
  end

  test "project_grade retrieve " do
    project = ProjectGrade.retrieve(1, "Assignment 1", 80)
    assert_equal project.class.name, "ProjectGrade"
    assert_equal project.student_id, 1
    assert_equal project.project_name, "Assignment 1"
    assert_equal project.section_id, 80
  end

  test "project_grade create/delete" do
    assert project = ProjectGrade.create(1, "Test Assignment", 80)
    assert ProjectGrade.exists?(1, "Test Assignment", 80)
    assert project.delete
    assert_not ProjectGrade.exists?(1, "Test Assignment", 80)
  end

  test "project_grade retrieve_students" do
    res = ProjectGrade.retrieve(1,"Assignment 1",80).retrieve_students
    assert_includes res, Student.retrieve(1)
    assert_includes res, Student.retrieve(3)
    assert_equal 2, res.size
  end
end
