class AdminController < ApplicationController
  before_filter :check_not_logged_in, :only => [:login, :signup]
  skip_before_filter :check_authentication, :check_authorization, :only => [:login, :logout, :signup]

  def check_not_logged_in
    if session[:user]
      flash[:notice] = I18n.t 'errors.already_logged_in'
      redirect_to :controller => "datebook", :action => "index"
    end
  end

  def login
    if request.post?
      begin 
        if params[:username_or_email] =~ /\@/
          session[:user] = User.authenticate_email(params[:username_or_email], params[:password]).id
        else
          session[:user] = User.authenticate_username(params[:username_or_email], params[:password]).id
        end
      rescue
        flash[:notice] = I18n.t 'errors.wrong_password'
        redirect_to :controller => "admin", :action => "login"
        return
      end
      flash[:notice] = I18n.t 'notices.logged_in'
      if (session[:intended_action] && session[:intended_controller])
        redirect_to :controller => session[:intended_controller],
                    :action => session[:intended_action],
                    :id => session[:intended_id]
        session[:intended_controller] = session[:intended_action] = session[:intended_id] = nil
        return
      end
      redirect_to :controller => "datebook", :action => "index"
    end
  end

  def logout
    session[:user] = nil
    flash[:notice] = I18n.t 'notices.logged_out'
    redirect_to :controller => "datebook", :action => "index"
  end

  def signup
    if request.post?
      @user = User.new(params[:user])
      if @user.save
        session[:user] = @user.id
        redirect_to :controller => "datebook", :action => "index"
        return
      end
    else
      @user = User.new
    end
  end
end
