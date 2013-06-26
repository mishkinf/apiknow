class Resource
  attr_accessor :name, :description, :routes

  def initialize(name, description, routes)
    @name = name
    @description = description
    @routes = routes
  end

  def human_readable
    routes_info = @routes.map do |r|
      r.to_s
    end.join("\n")

    "----------------------- #{@name} -----------------------\n" + routes_info
  end
end