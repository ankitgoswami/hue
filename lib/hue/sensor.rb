module Hue
  class Sensor
    include TranslateKeys

    # Unique identification number.
    attr_reader :id

    # Bridge the sensor is associated with.
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

    # The state hash for the sensor.
    attr_reader :state

    # Last updated time for the sensor.
    attr_reader :lastupdated

    def initialize(client, bridge, id, hash)
      @client = client
      @bridge = bridge
      @id = id
      unpack(hash)
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
      :manufacturer => :manufacturername,
    }

    STATE_KEYS_MAP = {
      :lastupdated => :lastupdated,
    }

    def unpack(hash)
      unpack_hash(hash, self.class::KEYS_MAP)
      unpack_hash(@state, self.class::STATE_KEYS_MAP)
    end

    def base_url
      "http://#{@bridge.ip}/api/#{@client.username}/sensors/#{id}"
    end
  end
end
