require 'erb'

class Static
  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)
    res = Rack::Response.new
    res['Content-type'] = 'text/html'
    begin
      data = File.open(req.path_info.sub('/',''), 'r').read
      res.status = '200'
      res.write(data)
    rescue
      res.status = '404'
      res.write('File not found')
    end
    res.finish
  end
end
