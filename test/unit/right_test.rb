require 'test_helper'

class RightTest < ActiveSupport::TestCase
  def setup
    @new_right = Right.new
    @new_right.name = "new right"
    @new_right.controller = "home"
    @new_right.actions = "index"
  end

  def test_new_role_saveable
    assert @new_right.save, "valid new right with one action not saveable"
  end

  def test_empty_name_saveable
    @new_right.name = nil
    assert !@new_right.save, "new right with empty name saveable"
  end

  def test_multiple_actions_comma_saveable
    @new_right.actions = "index, index"
    assert @new_right.save, "valid new right with multiple actions (,) not saveable"
  end

  def test_multiple_actions_semicolon_saveable
    @new_right.actions = "index; index"
    assert @new_right.save, "valid new right with multiple actions (;) not saveable"
  end

  def test_multiple_actions_space_saveable
    @new_right.actions = "index index"
    assert @new_right.save, "valid new right with multiple actions ( ) not saveable"
  end

  def test_all_actions_saveable
    @new_right.actions = "*"
    assert @new_right.save, "valid new right with all actions not saveable"
  end

  def test_invalid_actions_saveable
    @new_right.actions = "invalid* actions"
    assert !@new_right.save, "new right with invalid actions saveable"
  end

  def test_multiple_controllers_saveable
    @new_right.controller = "invalid controllers"
    assert !@new_right.save, "new right with multiple controllers saveable"
  end
end
