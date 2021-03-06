module Jobs
  TEMPORARY_EMAIL_FAILURES = [
      /execution expired/,
      /Temporary system problem\.\s+Please try again later\./,
      /Connection reset by peer/,
      /Connection refused - connect/,
      /end of file reached/
  ]

  def Jobs.temporary_email_failure?(exception)
    exception.class.name == 'Net::SMTPAuthenticationError' ||
        TEMPORARY_EMAIL_FAILURES.any? { |regexp| exception.message =~ regexp }
  end

  def Jobs.try_email_work
    try_count = 0
    begin
      yield
    rescue Exception => e
      raise e unless Jobs.temporary_email_failure?(e)
      try_count += 1
      if try_count < 5
        retry
      else
        raise "Too many failures attempting to deliver email. Is everything okay over at sendgrid?? Last error was: #{e.message}"
      end
    end
  end

  def Jobs.enqueue(obj, options = {})
      opts = {
          :payload_object => obj
      }.merge(options)
      Delayed::Job.enqueue(opts)

  end

  module ErrorTracking

    def error(job, exception)
      notify(exception)
    end

    def failure
      #TODO send an email?
    end

    def notify(exception)
      Airbrake.notify(exception)
    end

  end
end