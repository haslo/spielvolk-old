class AdminController < ApplicationController
  before_filter :check_not_logged_in, :only => [:login, :signup]

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
      if session[:intended_action] && session[:intended_controller]
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
    redirect_to :controller => "home", :action => "index"
  end

  def signup
    if request.post?
      signup_user = User.new
      signup_user.username = params[:username]
      signup_user.password = params[:password]
      signup_user.first_name = params[:first_name]
      signup_user.name = params[:name]
      signup_user.email = params[:email]
      signup_user.save
      session[:user] = signup_user.id
      redirect_to :controller => "home", :action => "index"
    end
  end
end
