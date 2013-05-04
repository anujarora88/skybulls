namespace :jobs do

  class Delayed::Job
    def self.already_queued?(klass)
      self.where('handler LIKE :handler', handler: klass).exists?()
    end

    def self.enqueue_once(job)
      with_exclusive_lock do
        enqueue(job) unless already_queued?(job.class)
      end
    end

    def self.with_exclusive_lock
      begin
        ActiveRecord::Base.connection.execute("lock tables delayed_jobs write")
        yield
      ensure
        ActiveRecord::Base.connection.execute("unlock tables")
      end
    end
  end

  desc "Add a parameter-less job to the delayed job queue"
  task :add => :environment do
    Delayed::Job.enqueue_once(eval("Jobs::#{ENV['NAME']}.new"))
  end
end