require './jobs/job'

module Jobs
  class NullJob < Job
    def initialize(client, request)
    end

    def >>(worker)
    end
  end
end
