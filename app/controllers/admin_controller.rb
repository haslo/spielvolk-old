class AdminController < ApplicationController
  before_filter :check_not_logged_in, :only => [:login, :signup]
  skip_before_filter :check_authentication, :check_authorization, :only => [:login, :logout, :signup]

  def check_not_logged_in
    if session[:user]
      flash[:notice] = I18n.t 'errors.already_logged_in'
      redirect_to :controller => "home", :action => "index"
    end
  end

  def login
    if request.post?
      begin 
        username = params[:username_or_email] =~ /\@/ ? User.find_by_email(params[:username_or_email]).username : params[:username_or_email]
        session[:user] = User.authenticate(username, params[:password]).id
      rescue
        flash[:notice] = I18n.t 'errors.wrong_password'
        redirect_to :controller => "admin", :action => "login"
        return
      end
      flash[:notice] = I18n.t 'notices.logged_in'
      if (session[:intended_action] && session[:intended_controller])
        redirect_to :controller => session[:intended_controller],
                    :action => session[:intended_action]
        session[:intended_controller] = session[:intended_action] = nil
        return
      end
      redirect_to :controller => "home", :action => "index"
    end
  end

  def logout
    session[:user] = nil
    flash[:notice] = I18n.t 'notices.logged_out'
    redirect_to :controller => "home", :action => "index"
  end

  def signup
      @user = User.new
  end

  def signups
    if request.post?
      @user = User.new(params[:user])
      if @user.save
        session[:user] = @user.id
        redirect_to :controller => "home", :action => "index"
        return
      end
    else
      @user = User.new
    end
  end
end
