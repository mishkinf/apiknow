require 'yaml'

folder = File.expand_path('..', __FILE__)
require File.join(folder, 'resource')
require File.join(folder, 'route')
require File.join(folder, 'param')

module Resources
  ROUTES_FILES = Dir['routes/*.yml']

  def self.load
    resources = []

    file_list = ENV['FILES'] && ENV['FILES'].split(',')
    ROUTES_FILES.each do |file|
      next if file_list && !file_list.empty? && !file_list.any?{|f| /#{f}/===file }
      routes_yml_file = File.read(file)
      resource_routes = YAML::load(routes_yml_file)

      resource_routes.keys.each do |resource|
        routes = []

        resource_routes[resource].each do |r|
          required_params = create_params_objects r[:required_params]
          optional_params = create_params_objects r[:optional_params]

          route = Route.new(r[:path], r[:description], r[:method], required_params, optional_params, r[:test_file])
          routes << route
        end

        resources << Resource.new(resource.to_s, "a resource definition", routes)
      end
    end

    resources
  end
end

def create_params_objects(params, request_type=:query)
  return nil unless params
  params.collect do |p|
    type = p[:type] || request_type

    Param.new(p[:name], p[:example_value], p[:description], type, p[:test_file])
  end
end
