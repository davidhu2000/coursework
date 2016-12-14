require 'active_support'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'erb'
require_relative './session'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res, route_params = {})
    @req = req
    @res = res
    @already_built_response = false
    @session = Session.new(req)
    @params = route_params.merge(req.params)
    @@protect_from_forgery ||= false
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    @res.status = 302
    @res.header['location'] = url
    @session.store_session(@res)
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
    @session.store_session(@res)
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
    @session
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
    if @@protect_from_forgery && @req.request_method != 'GET'
      check_authenticity_token
    else
      form_authenticity_token
    end

    self.send(name)
    render(name) unless @already_built_response
  end

  def form_authenticity_token
    @token ||= SecureRandom.urlsafe_base64(16)
    cookie = { path: '/', value: @token }
    @res.set_cookie('authenticity_token', cookie)
    cookie[:value]
  end

  def self.protect_from_forgery
    @@protect_from_forgery = true
  end

  def check_authenticity_token
    cookie = @req.cookies["authenticity_token"]
    unless cookie && cookie == @params["authenticity_token"]
      raise "Invalid authenticity token"
    end
  end
end
