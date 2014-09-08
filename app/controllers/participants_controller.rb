class ParticipantsController < ApplicationController
  respond_to :html
  load_resource
  before_filter :verify_owner, :only => [:edit, :update]

  def index
    respond_to do |format|
      format.json do
        render :json => @participants.map { |p| {:value => p.name, :tokens => p.name.split(" "), :id => p.id} }
      end
    end
  end

  def new
    respond_with(@participant)
  end

  def show
    respond_with(@participant)
  end

  def edit
    respond_with(@participant)
  end

  def update
    @participant.update_attributes(params[:participant])
    respond_with(@participant)
  end

  def create
    @participant.save!
    flash[:notice] = "Thanks for registering an account. You may now create sessions and mark sessions you'd like to attend."
    redirect_to root_path
  end

  private

  def verify_owner
    redirect_to @participant if @participant != current_participant
  end
end
