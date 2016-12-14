require 'erb'

class ShowExceptions
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def call(env)
    app.call(env)
  rescue Exception => e
    render_exception(e)
  end

  private

  def render_exception(e)
    filename = "lib/templates/rescue.html.erb"
    b = binding
    b.local_variable_set(:e, e)
    file = File.open(filename, 'r')
    body = ERB.new(file.read).result(b)
    # res = Rack::Response.new
    # res.write(body)
    # res.status = '500'
    # res['Content-type'] = 'text/html'
    # res.finish
    ['500' , {'Content-type' => 'text/html'}, body]
  end
end
