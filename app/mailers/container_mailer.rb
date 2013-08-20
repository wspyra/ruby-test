class ContainerMailer < ActionMailer::Base

  def send_container(container_id, from_email, email)
    @container = Container.find(container_id)
    attachments[@container.image_file_name] = File.read(@container.image.path)
    mail(to: email, from: from_email, subject: 'Test', body: 'Test')
  end

  def self.get_object(job)
    container_id = YAML.load(job.handler).args[0]
    Container.find(container_id)
  end

  def self.success(job)
    get_object(job).update_attribute :status_mail, JOB_STATUSES[:ok]
  end

  def self.error(job, exception)
    get_object(job).update_attribute :status_mail, JOB_STATUSES[:error]
  end

end
