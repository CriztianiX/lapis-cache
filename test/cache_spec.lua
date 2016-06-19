local request = require("lapis.spec.server").request
local use_test_server = require("lapis.spec").use_test_server

describe("Lapis cache engines", function()
  local cache
  
  setup(function()
    cache = require("lapis.cache.cache")
  end)
  
  describe("should be run", function()
    it("sure, i will run", function()
      assert.True(true)
    end)
  end)
  
  describe("configuration", function()
    it("should fail without configuration", function()
      assert.has.errors(function()
        cache:config("empty")
      end)
    end)

    it("should load default configuration", function()
      assert.same(cache:config(), {
        engine = "file"
      })
    end)

    it("should load redis configuration", function()
      assert.same(cache:config("redis"), {
        engine = "redis"
      })
    end)
  end)

  describe("redis resty engine", function()
    use_test_server()

    it("should write to cache", function()
      local status, body, headers = request("/redis/write?key=redis_key&value=redis_value")
      assert.same(status, 200)
    end)

    it("should read from cache", function()
      local status, body, headers = request("/redis/read?key=redis_key")
      assert.same(status, 200)
    end)
  end)

  describe("redis default engine", function()
    it("should write to cache", function()
      assert.True(cache:write("my_key", {
        cached = true
        }, "redis"))
    end)

    it("should read from cache", function()
      assert.same(cache:read("my_key", "redis"),  {
        cached = true
      })
    end)
  end)
end)