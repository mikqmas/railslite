require 'json'
require 'byebug'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    cookie = req.cookies['_rails_lite_app']
    if cookie.nil?
      @data = {}
    else
      @data = JSON.parse(cookie)
    end
  end

  def [](key)
    @data[key]
  end

  def []=(key, val)
    @data[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    cookie_attributes = {path: '/', value: @data.to_json}
    res.set_cookie("_rails_lite_app", cookie_attributes)
  end
end
