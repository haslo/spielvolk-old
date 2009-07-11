require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  def setup
    @new_role = Role.new
    @new_role.name = "new role"
  end

  def test_new_role
    assert @new_role.save, "valid new role not saveable"
  end

  def test_empty_name
    @new_role.name = nil
    assert !@new_role.save, "role with empty name saveable"
  end
end
