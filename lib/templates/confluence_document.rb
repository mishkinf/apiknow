require_relative '../document'
require 'json'
require 'cgi'

class ConfluenceDocument < Document
  def generate
    <<-DOC
      #{header}

      #{table_of_contents}

      #{
        @resources.map do |resource|
          resource.routes.map do |r|
            route_section r
          end
        end.flatten.join
      }
    DOC
  end

  def header
    <<-END
       h1. My API
       _Note: This API documentation is automagically generated_
   END
  end

  def table_of_contents
    <<-TOC
      {toc:printable=true|style=square|maxLevel=3|indent=5px|minLevel=2|class=bigpink|exclude=[1//2]|type=list|outline=no|include=.*}
    TOC
  end

  def route_section(route)
    required = parameter_table(route.required_params)
    optional = parameter_table(route.optional_params)

    example_output = "{code:language=javascript}" + example_output(route) + "{code}"

    if example_output.length > 2000
      example_output = "{expand:Click Here to Expand Example}" + example_output + "{expand}"
    end

    <<-END
      * h2. {color:black}#{CGI.escapeHTML(route.http_method.to_s.upcase)}{color} #{CGI.escapeHTML(route.path)}
      {section:align=left}
      {column}
      #{route.description}
      #{"h5. Required Parameters" if required}
      #{required}

      #{"h5. Optional Parameters" if optional}
      #{optional}

      h5. Example Requests
      {panel}
      #{example_requests(route)}
      {panel}

      h5. Example Output
      #{example_output}

      {column}
      {section}
    END
  end

  def example_requests(route)
    path_with_params = route.path_with_params

    host = 'http://gdata.youtube.com/'
    url = host + path_with_params

    "[#{CGI.escapeHTML(path_with_params)}|#{CGI.escapeHTML(url)}]"
  end

  def example_output(route)
    if route.test_file
      file = File.read File.expand_path "spec/responses/cbapi/#{route.test_file}"

      file_json = JSON.pretty_generate(JSON.parse(file))

      file_json.to_s
    else
      "No example output"
    end
  end

  def parameter_table(params)
    table_header = "||Param Name||Example Value||Description| \n"
    result = ""

    if params
      params.each do |p|
        result += "|#{p.name}|#{p.example_value}|#{p.description}| \n"
      end
    end

    return table_header + result if result.length > 0

    nil
  end
end

#begin
#  VirtualThingy.new.doThingy
#rescue VirtualMethodCalledError => e
#  raise unless e.name == :doThingy
#end
#ConcreteThingy.new.doThingy