module Rulers
  class Application
    def get_controller_and_action(env)
      _, constant, action, after = env["PATH_INFO"].split("/", 4)
      constant = constant.to_camel_case
      constant += "Controller"
      [Object.const_get(constant), action]
    end
  end
end
