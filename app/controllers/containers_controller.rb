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
    redirect_to containers_path if @container.nil?

    @container.addons.each do |a|
      a.contact_email = ContactEmail.new if a.contact_email.nil?
    end
  end

  def show
    @container = Container.find(params[:id])
  end

  def new
    @container = Container.new
  end

  def update
    @container = Container.find(params[:id])
    if @container.update_attributes(params[:container])
      redirect_to container_path, :notice => t(:saved)
    else
      render :edit
    end
  end

  def create
    @container = Container.new(params[:container])
    if @container.save
      @container.move_to_bottom
      redirect_to({:id => @container.id}, {:notice => t(:saved)})
    else
      render :new
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
      FtpUpload.new.delay(:run_at => Proc.new {10.seconds.from_now}).upload_container(FTP_SERVER_URL, FTP_SERVER_LOGIN, FTP_SERVER_PASSWORD, container)
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
        ContainerMailer.delay(:run_at => Proc.new { 10.seconds.from_now }).send_container(container.id, DEFAULT_FROM_EMAIL, params[:email])
        flash[:notice] = t :job_added
      end
    else
      flash[:error] = t 'incorrect_email'
    end unless container.nil?
    render json: {:status => 'OK'}
  end

end
