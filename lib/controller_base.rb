require 'active_support'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'erb'
require_relative './session'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res)
    @req = req
    @res = res
    @already_built_response = false
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    @res.status = 302
    @res.header['location'] = url
    render_content(@res, 'text/html')
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    raise if already_built_response?
    @already_built_response = true
    @res['Content-Type'] = content_type
    @res.write(content)
    @res.finish
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    filename = "views/#{self.class.name.underscore}/#{template_name}.html.erb"

    file = File.open(filename, 'r')
    erb = ERB.new(file.read)
    render_content(erb.result(binding), "text/html")
  end

  # method exposing a `Session` object
  def session
    Rack::Session
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
    render(name)
  end
end
