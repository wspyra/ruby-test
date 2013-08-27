require 'net/ftp'

class FtpClient < Net::FTP

  def mkdir_safe(dir_name)
    begin
      mkdir dir_name
    rescue
      # directory exists, do nothing
    end
  end

  def delete_safe(name)
    begin
      delete name
    rescue
      # file do not exists, do nothing
    end
  end

end