class Resource
  attr_accessor :name, :description, :routes, :host

  def initialize(name, description, routes, host)
    @name = name
    @description = description
    @routes = routes
    @host = host
  end

  def human_readable
    routes_info = @routes.map do |r|
      r.to_s
    end.join("\n")

    "----------------------- #{@name} -----------------------\n" + routes_info
  end
end