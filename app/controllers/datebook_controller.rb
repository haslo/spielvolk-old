class DatebookController < ApplicationController
  skip_before_filter :check_authentication, :check_authorization, :only => :index

  def index
    @event_instances = EventInstance.find(:all, :conditions => ["date BETWEEN ? AND ?", Time.now - 1.month, Time.now + 1.month])
  end
end
