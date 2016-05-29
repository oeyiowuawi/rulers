require "erubis"
class Rulers::Controller
  attr_reader :env, :request

  def initialize(env)
    @env = env
    @request ||= Rack::Request.new(env)
  end

  def response(body, status= 200, header={})
    @response = Rack::Response.new(body, status, header)
  end

  def get_response
    @response
  end

  def render(*args)
    response(render_template(*args))
  end

  def render_template(view_name, locals = {})
    file_name = File.join "app", "views", controller_name, "#{view_name}.html.erb"
    template = File.read file_name
    eruby = Erubis::Eruby.new(template)
    variables = {}
    instance_variables.each do |var|
      variables[var] = instance_variable_get(var)
    end

    eruby.result locals.merge variables  #.merge(env: env)
  end

  def controller_name
    klass = self.class.to_s.gsub(/Controller$/, "")
    klass.to_underscore
  end

  def params
    request.params
  end

  def dispatch(action)
    content = self.send(action)
    if get_response
      get_response
    else
      render(action)
      get_response
      #[200, {"content-type" => "text/html"}, [response]]
    end
  end

  def self.action(action_name)
    ->(env) {self.new(env).dispatch(action_name)}
  end

end
