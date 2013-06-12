module Jobs
  class Ping
    def initialize(client, message)
      @client = client
      @message = message
    end

    def run
      @client.send('PONG')
    end

    def >>(worker)
      worker << self
    end
  end
end
