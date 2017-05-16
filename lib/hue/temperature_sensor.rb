module Hue
  class TemperatureSensor < Sensor

    # Temperature in degrees celsius
    def temperature
      (@temperature / 100).round(2) if @temperature
    end

  private

    STATE_KEYS_MAP = Sensor::STATE_KEYS_MAP.merge(
      :temperature => :temperature
    )
  end
end
