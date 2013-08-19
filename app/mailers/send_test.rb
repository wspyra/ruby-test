class SendTest < ActionMailer::Base
  default from: 'ruby@<>.pl'

  def send_test(email, file_name, file)
    attachments[file_name] = File.read(file)
    mail(to: email, subject: 'Test', body: 'Test')
  end
  handle_asynchronously :send_test, :run_at => Proc.new { 10.seconds.from_now }

end
