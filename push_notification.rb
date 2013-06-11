require 'httpclient'

  class PushNotification
    def self.client
      @client ||= HTTPClient.new
    end

    def initialize(registration_id, alert)
      @registration_id = registration_id
      @alert = alert
    end

    def deliver
      self.class.client.post('https://android.googleapis.com/send', to_json, {
        "Authorization" => "key:AIzaSyCABSTd47XeIH",
        "Content-Type" => "application/josn"
      })
    end

    def to_json
      JSON.generate({
        "registration_ids" => [@registration_id],
        "data" => {
          "alert" => @alert
        }
      })
    end
  end
