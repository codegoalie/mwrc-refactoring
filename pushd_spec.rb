require 'rspec'
require 'webmock/rspec'

require 'socket'
require 'json'

describe "Push Daemon" do
  let(:socket) { UDPSocket.new }

  before(:all) do
    Thread.new { load "./pushd.rb" }
    sleep 0.01
  end

  describe 'commands' do
    describe 'PING' do
      it 'responds with PONG' do
        socket.send("PING", 0, '127.0.0.1', 6889)

        response, _ = socket.recvfrom(8)
        response.should eq 'PONG'
      end
    end

    describe 'SEND' do
      let(:token) { 't0k3n' }
      let(:message) { 'Hello, Steve. What is up?' }

      it 'delivers the message to the Google Cloud Messaging API' do
        stub_request :post, 'https://android.googleapis.com/send'

        socket.send("SEND #{token} \"#{message}\"",
                    0,
                    "127.0.0.1",
                    6889)

        sleep 0.01
        body = JSON.generate({
          'registration_ids' => [token],
          'data' => { 'alert' => message }
        })
        assert_requested :post,
                         'https://android.googleapis.com/send',
                         body: body
      end
    end
  end
end
