class DelayedJob

  STATUS_NEW = 'NEW'
  STATUS_IN_PROGRESS = 'IN_PROGRESS'
  STATUS_ERROR = 'ERROR'
  STATUS_OK = 'OK'

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
