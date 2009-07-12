class DatebookController < ApplicationController
  skip_before_filter :check_authentication, :check_authorization, :only => [:index, :show_event, :show_event_instance]

  def index
    all_event_instances = EventInstance.find(:all, :conditions => ["date BETWEEN ? AND ?", Time.now - 1.month, Time.now + 1.month])
    # different dbms implementations of boolean make this db-independent only in the controller
    @event_instances = all_event_instances.find_all { |event_instance| !event_instance.is_deleted }
  end

  def show_event_instance
  end

  def show_event
  end
end
