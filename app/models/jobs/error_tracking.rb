module Jobs
  module ErrorTracking

    def error(job, exception)
      notify(exception)
    end

    def failure
      #TODO send an email?
    end

    def notify(exception)
      params = {
          :error_class => self.class.name,
          :error_message => "Job failure on #{self.class.name}: #{exception.message}",
          :parameters => {}
      }

      Airbrake.notify(exception)
    end

  end
end