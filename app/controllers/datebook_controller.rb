class DatebookController < ApplicationController
  skip_before_filter :check_authentication, :check_authorization, :only => :index

  def index
  end
end
