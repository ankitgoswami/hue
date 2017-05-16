module Hue
  class SensorFactory

    def self.build_sensor(client, bridge, id, hash)
      sensor_type = hash["type"].to_sym
      sensor_class = SENSOR_TYPE_MAP[sensor_type] || Sensor

      sensor_class.new(client, bridge, id, hash)
    end

  private

    SENSOR_TYPE_MAP = {
      :Daylight => DaylightSensor,
      :ZLLTemperature => TemperatureSensor,
      :ZLLPresence => PresenceSensor,
      :ZLLLightLevel => LightSensor
    }
  end
end
