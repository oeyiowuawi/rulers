require "rulers/version"
require "rulers/routing"
require "rulers/controller"
require "rulers/utils"
require "rulers/dependencies"
module Rulers
  class Application
    def call(env)
      klass, action = get_controller_and_action(env)
      controller = klass.new(env)
      response = controller.send(action)
      [200, {"content-type" => "text/html"}, [response]]
    end
  end
end
