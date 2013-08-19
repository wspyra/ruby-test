class TestsController < ApplicationController

  def index
    if params[:move]
      test = Test.find_by_id(params[:id])
      case params[:move]
        when 'up'
          test.move_higher
        else
          test.move_lower
      end
      params[:move] = nil
      params[:id] = nil
      redirect_to params
    end
    @tests = Test.paginate :page => params[:page], :order => 'position ASC', :per_page => 10
  end

  def edit
    @test = Test.find_by_id(params[:id])
    @test_addons = @test.test_addons
    @action_method = :put
    @action_url = self.test_path
  end

  def show
    @test = Test.find(params[:id])
    @test_addons = @test.test_addons
  end

  def new
    @test = Test.new
    @action_url = tests_path
    @action_method = :post
    render :edit
  end

  def update
    @test = Test.find(params[:id])
    if params[:test][:delete_image] == 1
      params[:test][:image] = nil
    end
    if @test.update_attributes(params[:test])
      flash[:notice] = t :saved
      redirect_to :id => @test.id
    else
      @action_url = :save
      render :edit
    end
  end

  def create
    @test = Test.new(params[:test])
    @test.position = 0
    if @test.save
      flash[:notice] = t :saved
      @test.move_to_bottom
      redirect_to :action => :index
    else
      @action_method = :post
      render :edit
    end
  end

  def destroy
    @test = Test.find_by_id(params[:id])
    unless @test.nil?
      @test.destroy
      if @test.destroyed?
        flash[:notice] = t :deleted
      end
    end
    redirect_to :action => :index
  end

  def upload
    @test = Test.find_by_id(params[:id])
    unless @test.nil?
      if @test.status_upload.nil? ||
          @test.status_upload == DelayedJob::STATUS_ERROR ||
          @test.status_upload == DelayedJob::STATUS_OK

        delayed_job = DelayedJob.new
        @test.update_attribute(:status_upload, DelayedJob::STATUS_NEW)
        @test.save
        delayed_job.delay.upload(@test)
        flash[:notice] = t :job_added
      else
        flash[:error] = t :job_already_added
      end
    end
    redirect_to :action => :index
  end

  def send_email
    @test = Test.find_by_id(params[:id])
    unless @test.nil?
      if params[:email] =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
        if @test.status_mail.nil? ||
            @test.status_mail == DelayedJob::STATUS_ERROR ||
            @test.status_mail == DelayedJob::STATUS_OK

          delayed_job = DelayedJob.new
          @test.update_attribute(:status_mail, DelayedJob::STATUS_NEW)
          @test.save
          delayed_job.send_email(@test, params[:email])
          flash[:notice] = t :job_added
        else
          flash[:error] = t :job_already_added
        end
      else
        flash[:error] = t 'incorrect_email'
      end
    end
    render json: {:status => 'OK'}
  end

  def mail_test
    test = Test.find_by_id(6)
    email = 'wmms@o2.pl'
    SendTest.send_test(email, test.image_file_name, test.image.path).deliver
    render :text => 'asd'
  end

end
