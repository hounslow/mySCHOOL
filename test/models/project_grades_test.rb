require 'test_helper'

class ProjectGradesTest < ActionView::TestCase
  test "project_exists? true" do
    assert ProjectGrades.exists?(1,"Assignment 1",80)
  end

  test "project_exists? false" do
    assert_not ProjectGrades.exists?(2,'Assignment 1',80)
    assert_not ProjectGrades.exists?(1,'Assignment 5',80)
    assert_not ProjectGrades.exists?(1,'Assignment 1',78)
  end
end
