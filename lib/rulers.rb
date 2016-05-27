require "rulers/version"

module Rulers
  class Application
    def call(env)
      [200, {"content-type" => "text/html"}, ["Hello Again, my minions"]]
    end
  end
end
