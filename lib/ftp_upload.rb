class FtpUpload

  def upload_container(url, login, password, container)
    begin
      ftp = FtpClient.new url, login, password

      gz_file_name = container.image_file_name + GZ_EXT
      gz_file_path = container.image.path + GZ_EXT

      ftp.mkdir_safe container.id.to_s
      ftp.chdir container.id.to_s
      ftp.delete_safe gz_file_name

      file_content = File.read(container.image.path)
      gzip_content = ActiveSupport::Gzip.compress(file_content)
      file_handle = File.open(gz_file_path, 'wb')
      file_handle.puts  gzip_content
      file_handle.close

      ftp.putbinaryfile gz_file_path, gz_file_name
    rescue
      container.update_attribute :status_upload, JOB_STATUSES[:error]
    else
      container.update_attribute :status_upload, JOB_STATUSES[:ok]
    ensure
      File.delete gz_file_path
      ftp.quit
    end

    true
  end

end