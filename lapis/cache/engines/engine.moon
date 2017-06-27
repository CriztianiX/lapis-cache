util = require("lapis.util")

return class EngineCache
  @encode: (value) =>
    unless value
      error("encode, value missing")
    util.to_json(value)

  @decode: (value) =>
    unless value
      error("decode, value missing")
    util.from_json(value)

  @set_config: (config) =>
    @config = config
    return @

  @delete:(key) =>
    error("delete is delegated to engine")

  @read:(key) =>
    error("read is delegated to engine")
  
  @write:(key, value) =>
    error("write is delegated to engine")
