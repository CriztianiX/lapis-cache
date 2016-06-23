local EngineCache = require("lapis.cache.engines.engine")
local RestyEngine
do
  local _class_0
  local connection
  local _parent_0 = EngineCache
  local _base_0 = { }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...)
      return _class_0.__parent.__init(self, ...)
    end,
    __base = _base_0,
    __name = "RestyEngine",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  local self = _class_0
  connection = function()
    local redis = require("resty.redis")
    local red = redis:new()
    red:set_timeout(1000)
    local ok, err = red:connect(self.config.host or "127.0.0.1", self.config.port or 6379)
    if not (ok) then
      ngx.say("failed to connect: ", err)
      return 
    end
    return red
  end
  self.read = function(self, key)
    local conn = connection()
    local value = conn:get(key)
    if not (value) then
      return nil
    end
    return self:decode(value)
  end
  self.write = function(self, key, value)
    local conn = connection()
    local ans, err = conn:set(key, self:encode(value))
    if not (ans) then
      error("failed to set")
    end
    return true
  end
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  RestyEngine = _class_0
end
local DefaultEngine
do
  local _class_0
  local connection
  local _parent_0 = EngineCache
  local _base_0 = { }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  _class_0 = setmetatable({
    __init = function(self, ...)
      return _class_0.__parent.__init(self, ...)
    end,
    __base = _base_0,
    __name = "DefaultEngine",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        local parent = rawget(cls, "__parent")
        if parent then
          return parent[name]
        end
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  local self = _class_0
  connection = function()
    local redis = require("redis")
    return redis.connect(self.config.host or "127.0.0.1", self.config.port or 6379)
  end
  self.read = function(self, key)
    local conn = connection()
    local value = conn:get(key)
    if not (value) then
      return nil
    end
    return self:decode(value)
  end
  self.write = function(self, key, value)
    value = self:encode(value)
    local conn = connection()
    return conn:set(key, value)
  end
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  DefaultEngine = _class_0
end
if ngx and ngx.config then
  return RestyEngine
end
return DefaultEngine
