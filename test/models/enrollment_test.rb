require 'test_helper'

class EnrollmentTest < ActionView::TestCase
  test "enrollment exists" do
    assert Enrollment.exists?(1,80)
    assert_raises Enrollment.no_enrollment_error(3,80) {
      Enrollment.exists?(3,80)
    }
  end

  test "enrollment retrieve" do
    enrollment = Enrollment.retrieve(1,80)
    assert_equal enrollment.class.name, "Enrollment"
    assert_equal enrollment.student_id, 1
    assert_equal enrollment.section_id, 80
  end

  test "enroll/unenroll true" do
    assert enrollment = Enrollment.enroll(4,80)
    assert Enrollment.exists?(4,80)
    assert enrollment.unenroll
    assert_not Enrollment.exists?(4,80)
  end

  test "enroll/unenroll false" do
    # No such student
    assert_raises {
      Enrollment.enroll(8,80)
    }
    # No such section
    assert_raises {
      Enrollment.enroll(1,1000)
    }
    # Student already enrolled
    assert_raises {
      Enrollment.enroll(1,80)
    }

    # No such enrollment
    assert_raises Enrollment.no_enrollment_error(3,80) {
      Enrollment.retrieve(3,80).unenroll
    }
  end
end
