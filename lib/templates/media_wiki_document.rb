require_relative '../document'
require 'json'

class MediaWikiDocument < Document
  def generate
    <<-DOC
#{header}

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
= My API =
===== _Note: This API documentation is automagically generated =====
   END
  end

  def route_section(route)
    required = parameter_table(route.required_params)
    optional = parameter_table(route.optional_params)

    <<-END
== #{route.http_method.upcase} #{route.path} ==

=== Description ===
#{route.description} #{"\n=== Required Parameters ===\n#{required}\n" if required} #{"\n=== Optional Parameters ===\n#{optional}\n" if optional}

=== Example Requests ===
#{example_requests(route)}

=== Example Output ===
<syntaxhighlight lang="javascript">
#{example_output(route)}
</syntaxhighlight>

----
    END
  end

  def example_requests(route)
    path_with_params = route.path_with_params

    host = "http://mishkinfaustini.com/"
    url = host + path_with_params

    "[#{url} #{path_with_params}]"
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
    #table_header = "||Param Name||Example Value||Description| \n"
    #result = ""
    #
    #if params
    #  params.each do |p|
    #    result += "|#{p.name}|#{p.example_value}|#{p.description}| \n"
    #  end
    #end
    #
    #return table_header + result if result.length > 0

    nil
  end
end