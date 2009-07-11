class UnderDevelopmentController < ApplicationController
  skip_before_filter :check_authentication, :check_authorization, :only => :index
  layout 'plain'

  def index
  end
end
