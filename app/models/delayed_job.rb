class DelayedJob

  STATUS_NEW = 'NEW'
  STATUS_IN_PROGRESS = 'IN_PROGRESS'
  STATUS_ERROR = 'ERROR'
  STATUS_OK = 'OK'

  require 'net/ftp'

  def upload(test)
    test.status_upload = STATUS_IN_PROGRESS
    test.save

    if upload_real(test.image_file_name, test.image.path, test.id)
      test.status_upload = STATUS_OK
      test.save
      true
    else
      test.status_upload = STATUS_ERROR
      test.save
      false
    end
  end
  handle_asynchronously :upload, :run_at => Proc.new { 10.seconds.from_now }

  def upload_real(file_name, file, id)
    ftp = Net::FTP.new('<>.pl')
    ftp.login('ruby@<>.pl', '<pass>')
    begin
     ftp.mkdir(id.to_s)
    rescue
    end
    ftp.chdir(id.to_s)
    begin
      ftp.delete(file_name)
    rescue
    end
    ftp.putbinaryfile(file, file_name)
    ftp.quit()
    true
  end

  def send_email(test, email)
    test.status_mail = STATUS_IN_PROGRESS
    test.save
    if SendTest.delay.send_test(email, test.image_file_name, test.image.path)
      test.status_mail = STATUS_OK
      test.save
      true
    else
      test.status_upload = STATUS_ERROR
      test.save
      false
    end
  end

end
