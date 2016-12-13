require 'json'

class Flash

  def initialize(req)
    cookie = req.cookies['_rails_lite_app_flash']

    @now = cookie ? JSON.parse(cookie) : {}
    @flash = {}
  end

  def []=(key, val)
    @flash[key] = val
  end

  def [](key)
    @now[key.to_s] || @flash[key.to_s]
  end

  def store_flash(res)
    cookie = { path: '/', value: @flash.to_json }
    res.set_cookie('_rails_lite_app_flash', cookie)
  end

  def now
    @now
  end
end
