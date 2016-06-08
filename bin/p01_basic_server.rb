require 'rack'

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new

  res['Content-Type'] = "text/html"
  res.write(req.fullpath)
  res.redirect("http://www.google.com/", status = 302)
  res.finish
end

Rack::Server.start(
  app: app,
  Port: 3000
)
