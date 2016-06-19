EngineCache = require("lapis.cache.engines.engine")

class RestyEngine extends EngineCache
  connection = ->
    redis = require("resty.redis")
    red = redis\new!
    red\set_timeout 1000
    ok, err = red\connect(@config.host or "127.0.0.1", @config.port or 6379)
    unless ok
      ngx.say("failed to connect: ", err)
      return
    red

  @read: (key) =>
    conn = connection!
    value = conn\get key
    @decode value

  @write: (key, value) =>
    conn = connection!
    ans, err = conn\set key, @encode(value)

    unless ans
      error("failed to set")
    return true

class DefaultEngine extends EngineCache
  connection = ->
    redis = require("redis")
    redis.connect(@config.host or "127.0.0.1", @config.port or 6379)

  @read: (key) =>
    conn = connection!
    value = conn\get key
    @decode value

  @write: (key, value) =>
    value = @encode(value)
    conn = connection!
    conn\set key, value


if ngx and ngx.config
  return RestyEngine

return DefaultEngine


