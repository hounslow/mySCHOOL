require 'sql_helper'

class Section < ActiveRecord::Base
  def Section.exists?(section_id)
    return SqlHelper.exists?("section_teaches",
                   {"section_id" => section_id})
  end

  private
  def Section.no_section_error(section_id)
    "No section with ID #{section_id} exists"
  end

end
