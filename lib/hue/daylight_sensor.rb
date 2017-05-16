module Hue
  class DaylightSensor < Sensor

    # boolean representing if daylight is detected.
    attr_reader :daylight

  private

    STATE_KEYS_MAP = Sensor::STATE_KEYS_MAP.merge(
      :daylight => :daylight
    )
  end
end
