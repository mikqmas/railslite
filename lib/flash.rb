require 'json'

class Flash
  attr_reader :now

  def initialize(req)
    cookie = req.cookies['_rails_lite_app_flash']
    if cookie.nil?
      @data = {}
    else
      @data = JSON.parse(cookie)
    end
    @now = FlashStore.new(@data)
    @flash = FlashStore.new
  end

  def [](key)
    @now[key] || @flash[key]
  end

  def []=(key, value)
    @flash[key] = value
  end


  def store_flash(res)
    cookie_attributes = {path: '/', value: @flash.to_json}
    res.set_cookie("_rails_lite_app_flash", cookie_attributes)
  end
end

class FlashStore
  def initialize(data={})
    @data = data
  end

  def [](key)
    val = @data[key]
  end

  def []=(key,val)
    @data[key]= val
  end

  def to_json
    @data.to_json
  end

end
