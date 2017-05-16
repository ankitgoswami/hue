module Hue
  class PresenceSensor < Sensor

    # boolean representing if presence is detected.
    attr_reader :presence

  private

    STATE_KEYS_MAP = Sensor::STATE_KEYS_MAP.merge(
      :presence => :presence
    )
  end
end
