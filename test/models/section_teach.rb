require 'test_helper'

class SectionTeachTest < ActionView::TestCase
  test "section_teach exists?" do
    assert SectionTeach.exists?(80)
    assert_not SectionTeach.exists?(100)
  end

  test "section_teach create/delete true" do
    assert section_teach = SectionTeach.create(99,"Test", 1)
    assert section_teach.delete
    assert_not SectionTeach.exists?(99)
  end
end
