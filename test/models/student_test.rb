require 'test_helper'

class StudentTest < ActionView::TestCase
  test "student_exists? true" do
    assert Student.exists?(1)
  end

  test "student_exists? false" do
    assert_not Student.exists?(8)
  end

  test "enrolled_in? true" do
    assert Student.retrieve(1).enrolled_in?(80)
  end

  test "enrolled_in? false" do
    assert_not Student.retrieve(1).enrolled_in?(78)
  end

  test "create_project true" do
    assert_not ProjectGrades.exists?(1,'Assignment 3',80)
    assert Student.retrieve(1).create_project('Assignment 3', 80)
    assert ProjectGrades.exists?(1,'Assignment 3',80)
  end

  test "create_project false" do
    # No such student
    assert_raises Student.no_student_error(8) {
      Student.retrieve(8).create_project('Assignment 1', 80)
    }
    assert_raises Student.not_enrolled_error(78) {
      Student.retrieve(1).create_project('Assignment 1', 78)
    }
    # Project exists
    assert_raises ProjectGrades.project_exists_error {
      Student.create_project(1, 'Assignment 1', 80)
    }
  end

  test "retrieve_grades true" do
    # Student has grades in at least one course
    assert_not Student.retrieve(3).grades.empty?
    # Student has grades in specified course
    assert_not Student.retrieve(3).grades(78).empty?
  end

  test "retrieve_grades false" do
    # Student has no grades at all
    assert_raises Student.no_grades_notice {
      Student.retrieve(2).grades.empty?
    }
    # Student has no grades in specified course
    assert_raises Student.no_grades_notice(80) {
      Student.retrieve(3).grades(3,80).empty?
    }
  end

  test "retrieve_projects" do
    # Student has projects
    projects = Student.retrieve(1).projects
    projects.map!{|a| {"name" => a.project_name, "section" => a.section_id}}
    assert_includes projects, {"name" => "Assignment 1", "section" => 80}
    assert_includes projects, {"name" => "Assignment 2", "section" => 80}
    assert_equal projects.size, 2
    # Student has no projects
    projects2 = Student.retrieve(2).projects
    assert_empty projects2
  end

end
