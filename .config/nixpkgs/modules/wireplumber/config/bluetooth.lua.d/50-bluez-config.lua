bluez_monitor.properties = {
  ["bluez5.codecs"] = "[ sbc aac ldac aptx aptx_ll aptx_ll_duplex ]",
  ["bluez5.enable-sbc"] = true,
  ["bluez5.enable-aac"] = true,
  ["bluez5.enable-ldac"] = true,
  ["bluez5.enable-hw-volume"] = true,
  ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]",
  ["bluez5.hfphsp-backend"] = "native",
  ["bluez5.default.rate"] = 48000,
  ["bluez5.default.channels"] = 2,
}
bluez_monitor.rules = {
  {
    matches = {
      { "device.name", "matches", "bluez_card.*" },
    },
    apply_properties = {
      ["bluez5.auto-connect"] = "[ hfp_hs hsp_hs a2dp_sink ]",
      ["bluez5.a2dp.ldac.quality"] = "hq",
    }
  }
}