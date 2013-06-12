module Jobs
  class Job
    def initialize(client, request)
      @client = client
      @request = request
    end

    def run
    end

    def >>(worker)
      worker << self
    end
  end
end
