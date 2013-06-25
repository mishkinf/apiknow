Dir["#{File.dirname(__FILE__)}/lib/**/*.rb"].each { |f| load(f) }
puts "Finished loading all required files."

require 'uri'
require 'text-table'

print "Enter a host (e.g. http://mishkinfaustini.com/): "
host = gets.chomp

RESOURCES = []

def available_actions
  puts "\n"

  actions_arr = [
    ["1.", "Add Resource"],
    ["2.", "Add Route"],
    ["3.", "List Resources"],
    ["4.", "List Routes"],
    ["q.", "Exit"],
  ]

  puts Text::Table.new(:head => ["Key","Action"], :rows => actions_arr).to_s
end

def list_resources
  puts ""
  puts "Resources"
  resources_arr = RESOURCES.each_with_index.map { |p, index| [index+1, p.name, p.description]}
  puts Text::Table.new(:head => ["Index","Resource Name","Description"], :rows => resources_arr).to_s
end

def add_resource
  puts "\nCreating new resource..."
  name        = prompt("Resource name")
  description = prompt("Resource Description")

  RESOURCES << Resource.new(name, description, [])
end

def list_routes_for_resource(resource)
  puts "\nRoutes for #{resource.name}"
  routes_arr = resource.routes.each_with_index.map { |p, index| [index+1, p.path, p.description]}
  puts Text::Table.new(:head => ["Index","Route Path","Description"], :rows => routes_arr).to_s
end

def add_route
  puts "\nCreating new route..."
  list_resources
  puts ""

  resource_index = prompt("Select Resource").to_i - 1

  path        = prompt("Path")
  description = prompt("Description")
  http_method = prompt("HTTP Method")

  puts RESOURCES.count
  puts resource_index
  puts RESOURCES[resource_index]
  RESOURCES[resource_index].routes << Route.new(path, description, http_method, [], [])

  list_routes_for_resource RESOURCES[resource_index]
end

def prompt(name)
  print "#{name}: "
  gets.chomp
end

while true
  available_actions

  action_num = prompt("Choose action")
  exit if action_num == 'q' || action_num == 'quit' || action_num == 'exit'

  case action_num
    when '1'
      add_resource
    when '2'
      add_route
    when '3'
      list_resources
    when '4'
      resource_index = prompt("Select Resource").to_i - 1
      list_routes_for_resource RESOURCES[resource_index]
  end

  list_resources
end
