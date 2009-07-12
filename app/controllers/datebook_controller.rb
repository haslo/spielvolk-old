class DatebookController < ApplicationController
  skip_before_filter :check_authentication, :check_authorization, :only => [:index, :show_event, :show_event_instance]

  def index
    @all_event_instances = fetch_all_event_instances
    @upcoming_event_instances = fetch_event_instances(Time.now - 1.day, Time.now + 1.week)
  end

  def show_event_instance
    @all_event_instances = fetch_all_event_instances
    @event_instance = EventInstance.find_by_id(params[:id])
    if @event_instance.event.event_instances.size == 1
      redirect_to :action => "show_event"
    end
  end

  def show_event
    @all_event_instances = fetch_all_event_instances
  end

private

  def fetch_all_event_instances
    @all_event_instances = fetch_event_instances Time.now - 1.month, Time.now + 1.month
  end

  def fetch_event_instances(start_date, end_date)
    event_instances = EventInstance.find(:all, :conditions => ["date BETWEEN ? AND ?", start_date, end_date])
    # different dbms implementations of boolean make this db-independent only if applied in the controller
    event_instances.find_all { |event_instance| !event_instance.is_deleted }
  end
end
