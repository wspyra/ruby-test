class Container < ActiveRecord::Base

  has_attached_file :image, :styles => { :medium => '300x300>', :thumb => '100x100>' }, :default_url => '/assets/missing.png'

  attr_accessible :id, :name, :data, :position, :visible, :addons_attributes, :image, :delete_image

  attr_protected :image_file_name, :image_content_type, :image_file_size

  validates_presence_of :name, :position, :on => :create
  validates_uniqueness_of :name

  has_many :addons, :dependent => :destroy
  accepts_nested_attributes_for :addons, :reject_if => :all_blank, :allow_destroy => true

  acts_as_list

  def delete_image=(value)
    @delete_image = !value.to_i.zero?
  end

  def delete_image
    !!@delete_image
  end

  alias_method :delete_image?, :delete_image

  def upload

  end

  require 'net/ftp'

  def upload_ftp
    ftp = Net::FTP.new FTP_SERVER_URL
    ftp.login FTP_SERVER_LOGIN, FTP_SERVER_PASSWORD
    begin
      ftp.mkdir id.to_s
    rescue
      # directory exists, do nothing
    end
    ftp.chdir(id.to_s)
    begin
      ftp.delete :image_file_name
    rescue
      # file do not exists, do nothing
    end
    begin
      ftp.putbinaryfile image.path, image_file_name
    rescue
      update_attribute :status_upload, JOB_STATUSES[:error]
    end
    update_attribute :status_upload, JOB_STATUSES[:ok]
    ftp.quit
    true
  end
  handle_asynchronously :upload, :run_at => Proc.new { 10.seconds.from_now }

end
