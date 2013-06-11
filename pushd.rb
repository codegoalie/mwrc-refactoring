require 'thread'
require 'json'

require './push_daemon'

daemon = PushDaemon.new
daemon.start
