module Hue
  class Sensor
    include TranslateKeys
    include EditableState

    # Unique identification number.
    attr_reader :id

    # Bridge the sensor is associated with
    attr_reader :bridge

    # A unique, editable name given to the sensor.
    attr_accessor :name

    # A fixed name describing the type of sensor.
    attr_reader :type

    # The hardware model of the sensor.
    attr_reader :model

    # An identifier for the software version running on the sensor.
    attr_reader :software_version

    # The name of the sensor manufacturer.
    attr_reader :manufacturer

    attr_reader :state

    attr_reader :buttonevent

    attr_reader :lastupdated

    attr_reader :temperature

    attr_reader :presence

    attr_reader :lightlevel

    attr_reader :dark

    attr_reader :daylight

    attr_reader :status

    def initialize(client, bridge, id, hash)
      @client = client
      @bridge = bridge
      @id = id
      unpack(hash)
    end

    def name=(new_name)
      unless (1..32).include?(new_name.length)
        raise InvalidValueForParameter, 'name must be between 1 and 32 characters.'
      end

      body = {
        :name => new_name
      }

      uri = URI.parse(base_url)
      http = Net::HTTP.new(uri.host)
      response = http.request_put(uri.path, JSON.dump(body))
      response = JSON(response.body).first
      if response['success']
        @name = new_name
      # else
        # TODO: Error
      end
    end

    # Refresh the state of the sensor
    def refresh
      json = JSON(Net::HTTP.get(URI.parse(base_url)))
      unpack(json)
    end

  private

    KEYS_MAP = {
      :state => :state,
      :type => :type,
      :name => :name,
      :model => :modelid,
      :software_version => :swversion,
      :manufacturer => :manufacturername
    }

    STATE_KEYS_MAP = {
      :buttonevent => :buttonevent,
      :lastupdated => :lastupdated,
      :temperature => :temperature,
      :presence => :presence,
      :lightlevel => :lightlevel,
      :dark => :dark,
      :daylight => :daylight,
      :status => :status,
    }

    def unpack(hash)
      unpack_hash(hash, KEYS_MAP)
      unpack_hash(@state, STATE_KEYS_MAP)
    end

    def base_url
      "http://#{@bridge.ip}/api/#{@client.username}/sensors/#{id}"
    end
  end
end
