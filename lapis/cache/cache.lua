local config = require("lapis.config").get()
local assert_config
assert_config = function(configuration)
  if (not config) or (not config.cache) or not (config.cache[configuration]) then
    error(tostring(configuration) .. " not configured in cache")
  end
  return config.cache[configuration]
end
local assert_engine
assert_engine = function(configuration, engine)
  if not (configuration[engine]) then
    return error(tostring(engine) .. " not configured in " .. tostring(configuration))
  end
end
local load_engine
load_engine = function(cfg)
  local ng = "lapis.cache.engines." .. cfg.engine
  local ok, mod = pcall(require, ng)
  if not ok then
    error("engine " .. tostring(engine) .. " not found")
  end
  mod:set_config(cfg)
  return mod
end
local Cache
do
  local _base_0 = { }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function() end,
    __base = _base_0,
    __name = "Cache"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  local self = _class_0
  self.config = function(self, configuration)
    if configuration == nil then
      configuration = "default"
    end
    return assert_config(configuration)
  end
  self.read = function(self, key, configuration)
    if configuration == nil then
      configuration = "default"
    end
    local cfg = self:config(configuration)
    local engine = load_engine(cfg)
    return engine:read(key)
  end
  self.write = function(self, key, value, configuration)
    if configuration == nil then
      configuration = "default"
    end
    if not (key) then
      error("missing key")
    end
    if not (value) then
      error("missing value")
    end
    local cfg = self:config(configuration)
    local engine = load_engine(cfg)
    return engine:write(key, value)
  end
  Cache = _class_0
  return _class_0
end
