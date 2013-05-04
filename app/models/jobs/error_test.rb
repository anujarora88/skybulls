module Jobs
  class ErrorTest
    include ErrorTracking

    def perform
      raise "Error testing!"

    end

  end
end
