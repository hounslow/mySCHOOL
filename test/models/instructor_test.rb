require 'test_helper'

class InstructorTest < ActionView::TestCase
  test "grade true" do
    assert Instructor.grade(3, 1, 'Assignment 1' 80)
    assert ProjectGrades.exists?(1, 'Assignment 1', 80)
  end
