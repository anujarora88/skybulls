module Jobs


  class Work
    def self.enqueue(obj, options = {})
      if Rails.env.development?
        obj.perform
      else
        opts = {
            :payload_object => obj
        }.merge!(options)
        Delayed::Jobs.enqueue(opts)
      end
    end
  end

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
          :parameters => struct_members
      }

      Airbrake.notify(params)
    end

  end


end
