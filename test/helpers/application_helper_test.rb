require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "exists? true" do
    assert exists?("students", {"student_id" => 1})
  end

  test "exists? false" do
    assert_not exists?("students", {"student_id" => 8})
  end

  test "student_exists? true" do
    assert student_exists?(1)
  end

  test "student_exists? false" do
    assert_not student_exists?(8)
  end

  test "registered_in? true" do
    assert registered_in?(1,80)
  end

  test "registered_in? false" do
    assert_not registered_in?(1,78)
  end

  test "project_exists? true" do
    assert project_exists?(1,"Assignment 1",80)
  end

  test "project_exists? false" do
    assert_not project_exists?(2,'Assignment 1',80)
    assert_not project_exists?(1,'Assignment 5',80)
    assert_not project_exists?(1,'Assignment 1',78)
  end

  test "create_project true" do
    assert_not project_exists?(1, 'Assignment 3', 80)
    assert create_project(1, 'Assignment 3', 80)
    assert project_exists?(1, 'Assignment 3', 80)
  end

  test "create_project false" do
    # No such student
    assert_not create_project(8, 'Assignment 1', 80)
    assert_equal no_student_error(8), flash[:error]
    # Student not registered in course
    assert_not create_project(1, 'Assignment 1', 78)
    assert_equal not_registered_error(78), flash[:error]
    # Project exists
    assert_not create_project(1, 'Assignment 1', 80)
    assert_equal project_exists_error, flash[:error]
  end

  test "retrieve_grades true" do
    # Student has grades in at least one course
    assert_not retrieve_grades(3).empty?
    # Student has grades in specified course
    assert_not retrieve_grades(3, 78).empty?
    # Student has no grades at all
    assert retrieve_grades(2).empty?
    # Student has no grades in specified course
    assert retrieve_grades(3,80).empty?
  end

  test "retrieve_grades false" do
    # No such student
    assert_not retrieve_grades(8)
    assert_equal no_student_error(8), flash[:error]
  end
end
