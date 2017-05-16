module Hue
  class LightSensor < DaylightSensor

    # amount of light detected by the sensor.
    attr_reader :lightlevel

  # boolean representing if darkness is detected.
    attr_reader :dark

  private

    STATE_KEYS_MAP = DaylightSensor::STATE_KEYS_MAP.merge(
      :lightlevel => :lightlevel,
      :dark => :dark
    )
  end
end
