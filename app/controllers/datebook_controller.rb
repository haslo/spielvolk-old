class DatebookController < ApplicationController
  skip_before_filter :check_authentication, :check_authorization, :only => [:index, :show_event, :show_event_instance]

  def index
    @all_event_instances = fetch_all_event_instances
    @upcoming_event_instances = fetch_event_instances(Time.now - 1.day, Time.now + 1.week)
  end

  def show_event_instance
    prepare_event_instance
    if @event_instance.event.event_instances.size == 1
      redirect_to :action => "show_event", :id => @event_instance.event.id
      return
    end
  end

  def edit_event_instance
    prepare_event_instance
  end

  def show_event
    prepare_event
  end

  def edit_event
    prepare_event
  end

private

  def prepare_event_instance
    @all_event_instances = fetch_all_event_instances
    @event_instance = EventInstance.find_by_id(params[:id])
    @event = @event_instance.event
  end

  def prepare_event
    @all_event_instances = fetch_all_event_instances
    @event = Event.find_by_id(params[:id])
  end

  def fetch_all_event_instances
    @all_event_instances = fetch_event_instances Time.now - 1.month, Time.now + 1.month
  end

  def fetch_event_instances(start_date, end_date)
    event_instances = EventInstance.find(:all, :conditions => ["date BETWEEN ? AND ?", start_date, end_date])
    # different dbms implementations of boolean make this db-independent only if applied in the controller
    event_instances.find_all { |event_instance| !event_instance.is_deleted }
  end
end
