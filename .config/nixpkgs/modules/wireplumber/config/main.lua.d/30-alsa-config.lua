alsa_monitor.properties = {
  ["alsa.jack-device"] = false,
  ["alsa.reserve"] = true,
  ["alsa.reserve.priority"] = -15,
  ["alsa.reserve.application-name"] = "WirePlumber",
}
alsa_monitor.rules = {
  matches = {
    {
      { "node.name", "matches", "alsa_input.*" },
    },
    {
      { "node.name", "matches", "alsa_output.*" },
    },
    {
      { "device.name", "matches", "alsa_card.*" },
    },
  },
  apply_properties = {
    ["priority.driver"] = 88,
    ["priority.session"] = 88,
    ["resample.quality"] = 4,
    ["api.alsa.use-ucm"] = true,
    ["api.alsa.use-acm"] = false,
    ["api.alsa.soft-mixer"] = false,
    ["api.alsa.ignore-dB"] = false,
    ["api.alsa.period-size"] = 32,
    ["api.alsa.headroom"] = 0,
    ["audio.format"] = "S32LE",
    ["audio.rate"] = "48000",
    ["audio.allowed-rates"] = "32000,44100,48000,88200,96000,1764000,192000",
    ["audio.channels"] = 2,
    ["audio.position"] = "FL,FR",
    ["channelmix.normalize"] = true,
    ["latency.internal.rate"] = 0,
    ["latency.internal.ns"] = 0,
    ["session.suspend-timeout-seconds"] = 0,
  },
}