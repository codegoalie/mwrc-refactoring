require 'thread'
require 'httpclient'
require 'json'

require './push_daemon'

daemon = PushDaemon.new
daemon.start
