class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(params[:event])
    if @event.save
      flash[:notice] = 'Event Created Succesfully'
      redirect_to event_path(@event)
    else
      render :action=>'new', :flash=>{:notice=>'Error Occured while creation'}
    end
       
  end

  def show
    @event = Event.find(params[:id])
  end

end
