require './worker'
require './udp_server'
require './jobs'
require './client'
require './request'

class PushDaemon
  def initialize
    @worker = Worker.new
    @server = UDPServer.new(self)
  end

  def start
    @worker.spawn(10)
    @server.listen(6889)
  end

  def call(client, message)
    request = Request.new(message)
    job = Jobs.factory(client, request)

    @worker << job
  end
end

