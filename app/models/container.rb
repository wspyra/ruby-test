class Container < ActiveRecord::Base

  has_attached_file :image, :styles => { :medium => '300x300>', :thumb => '100x100>' }, :default_url => '/assets/missing.png'

  attr_accessible :id, :name, :data, :position, :visible, :addons_attributes, :image, :delete_image

  attr_protected :image_file_name, :image_content_type, :image_file_size

  validates_presence_of :name, :position
  validates_uniqueness_of :name

  has_many :addons, :dependent => :destroy
  accepts_nested_attributes_for :addons, :reject_if => :all_blank, :allow_destroy => true

  attr_accessor :delete_image

  before_validation { image.clear if delete_image == '1' }

  acts_as_list

  def upload_ftp
    gz_file_name = :image_file_name.to_s + GZ_EXT
    gz_file_path = image.path + GZ_EXT

    begin
      ftp = FtpClient.new FTP_SERVER_URL, FTP_SERVER_LOGIN, FTP_SERVER_PASSWORD
    rescue
      # ftp.logged_in in rails 3.2.12 disappear..
      return false
    end
    ftp.mkdir_safe id.to_s
    ftp.chdir id.to_s
    ftp.delete_safe gz_file_name

    file_content = File.read(image.path)
    gzip_content = ActiveSupport::Gzip.compress(file_content)
    file_handle = File.open(gz_file_path, 'wb')
    file_handle.puts  gzip_content
    file_handle.close

    begin
      ftp.putbinaryfile gz_file_path, gz_file_name
    rescue
      update_attribute :status_upload, JOB_STATUSES[:error]
    end

    File.delete gz_file_path

    update_attribute :status_upload, JOB_STATUSES[:ok]
    ftp.quit
    true
  end

end
