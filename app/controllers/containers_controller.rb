class ContainersController < ApplicationController

  def index
    if params[:move]
      container = Container.find_by_id(params[:id])
      case params[:move]
        when 'up'
          container.move_higher
        else
          container.move_lower
      end
      params[:move] = nil
      params[:id] = nil
      redirect_to params
    end
    @containers = Container.paginate :page => params[:page], :order => 'position ASC', :per_page => 10
  end

  def edit
    @container = Container.find_by_id(params[:id])
    @action_method = :put
    @action_url = self.container_path
  end

  def show
    @container = Container.find(params[:id])
  end

  def new
    @container = Container.new
    @action_url = containers_path
    @action_method = :post
    render :edit
  end

  def update
    @container = Container.find(params[:id])
    if params[:container][:delete_image] == 1
      params[:container][:image] = nil
    end
    if @container.update_attributes(params[:container])
      flash[:notice] = t :saved
      redirect_to :id => @container.id
    else
      @action_url = :save
      render :edit
    end
  end

  def create
    @container = Container.new(params[:container])
    @container.position = 0
    if @container.save
      flash[:notice] = t :saved
      @container.move_to_bottom
      redirect_to :action => :index
    else
      @action_method = :post
      render :edit
    end
  end

  def destroy
    @container = Container.find_by_id(params[:id])
    unless @container.nil?
      @container.destroy
      if @container.destroyed?
        flash[:notice] = t :deleted
      end
    end
    redirect_to :action => :index
  end

  def upload
    container = Container.find_by_id(params[:id])
    if container.status_upload == JOB_STATUSES[:in_progress]
      flash[:error] = t :job_already_added
    else
      container.update_attribute(:status_upload, JOB_STATUSES[:in_progress])
      container.delay.upload_ftp
      flash[:notice] = t :job_added
    end unless container.nil?
    redirect_to :action => :index, :page => params[:page]
  end

  # ajax action
  def send_email
    container = Container.find_by_id(params[:id])
    if params[:email] =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      if container.status_mail == JOB_STATUSES[:in_progress]
        flash[:error] = t :job_already_added
      else
        container.update_attribute(:status_mail, JOB_STATUSES[:in_progress])
        container.delay.send_email(params[:email])
        flash[:notice] = t :job_added
      end
    else
      flash[:error] = t 'incorrect_email'
    end unless container.nil?
    render json: {:status => 'OK'}
  end


end
