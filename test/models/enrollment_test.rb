require 'test_helper'

class EnrollmentTest < ActionView::TestCase
  test "enroll true" do
    assert Enrollment.enroll(4,80)
#    assert_equal successful_enrollment_notice(80), flash[:notice]
    assert Enrollment.exists?(4,80)
  end

  test "enroll false" do
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
  end
end
