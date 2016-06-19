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

  describe("redis engine", function()
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