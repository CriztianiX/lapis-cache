local lapis = require("lapis")
local app = lapis.Application()
local cache = require("lapis.cache.cache")

app:match("/redis/write", function(self)
  local key = self.params.key
  local value = self.params.value
  local res = cache:write(key, value, "redis")
  local status = res and 200 or 500
  return { json = {}, status = status}
end)

app:match("/redis/read", function(self)
  local key = self.params.key
  local res = cache:read(key, "redis")
  local status = res and 200 or 500
  return { json = {}, status = status}
end)

return app
