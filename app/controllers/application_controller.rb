class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  layout 'standard'
  before_filter :check_authentication, :check_authorization
  before_filter :set_locale

  def check_authentication
    unless session[:user]
      session[:intended_action] = action_name
      session[:intended_controller] = controller_name
      flash[:notice] = I18n.t 'errors.not_logged_in'
      redirect_to :controller => "admin", :action => "login"
    end
  end

  def check_authorization
    user = User.find(session[:user])
    unless user.roles.detect { |role|
      role.rights.detect { |right|
          ('*' == right.actions || Regexp.new(action_name) =~ right.actions) &&
          right.controller == self.class.controller_path
        }
      }
      flash[:notice] = I18n.t 'errors.not_authorized'
      request.env["HTTP_REFERER"] ? (redirect_to :back) : (redirect_to :controller => "home", :action => "index")
    end
  end

  def set_locale
    # if params[:locale] is nil then I18n.default_locale will be used
    I18n.locale = params[:locale]
  end 

  def default_url_options(options={})
    { :locale => I18n.locale }
  end
end
