require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.find_by_username("user")
    @new_user = User.new
    @new_user.username = "new_user"
    @new_user.email = "haslo@haslo.ch"
  end
  
  def test_save_new_user
    @new_user.password = "password"
    @new_user.password_confirmation = "password"
    assert @new_user.save, "valid new user not saveable"
  end

  def test_save_fetched_user
    assert @user.save, "fetched user not saveable"
  end

  def test_save_blank_user
    assert !User.new.save, "invalid (blank) new user saveable"
  end

  def test_save_user_email
    @user.email = "test@promino.ch"
    assert @user.save, "user not saveable after changing email"
  end

  def test_save_user_password
    @user.password = "test"
    @user.password_confirmation = "test"
    assert @user.save, "user not saveable after changing password"
  end

  def test_inexistant_password_existing
    @user.password = nil
    @user.password_confirmation = nil
    assert @user.save, "empty password not saved, existing user"
  end

  def test_inexistant_password_new
    assert !@new_user.save, "empty password saved, new user"
  end

  def test_username_empty
    @user.username = nil
    assert !@user.save, "empty username saved"
  end

  def test_username_not_unique
    @new_user.username = "admin"
    @new_user.password = "password"
    @new_user.password_confirmation = "password"
    assert !@new_user.save, "non-unique username saved for new user"
  end

  def test_email_matches_pattern
    @user.email = "not an email"
    assert !@user.save, "incorrect email address saved"
  end

  def test_email_existing_host
    @user.email = "somename@invalid.domain"
    assert !@user.save, "email address with non-existing host saved"
  end

  def test_email_existing_host
    @user.email = "somename@invalidhostinvalidhost.ch"
    assert !@user.save, "email address with non-existing host saved"
  end

  def test_non_confirmed_password
    @user.password = "password"
    @user.password_confirmation = nil
    assert !@user.save, "non-confirmed password saved"
  end
end