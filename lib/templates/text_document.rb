require_relative '../document'
require 'json'
require 'text-table'

class TextDocument < Document
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
------------------------------------------------
My API
================================================
_Note: This API documentation is automagically generated_
   END
  end

  def route_section(route)
    required = parameter_table(route.required_params)
    optional = parameter_table(route.optional_params)

    <<-END

********************************************************************
* #{route.http_method.upcase} #{route.path}
********************************************************************

* Description
-----------
#{route.description}

#{"Required Parameters\n#{required}" if required}

#{"Optional Parameters\n#{optional}" if optional}

Example Requests
----------------
#{example_requests(route)}

Example Output
--------------
#{example_output(route)}
    END
  end

  def example_requests(route)
    path_with_params = route.path_with_params

    host = 'http://gdata.youtube.com/'

    url = host + path_with_params

    "#{path_with_params} - #{url}"
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

    return unless params
    table_header = "Param Name\t\tExample Value\t\tDescription \n"

    params_arr = params.map { |p| [p.name, p.example_value, p.description]}

    Text::Table.new(:head => ["Param Name","Example Value","Description"], :rows => params_arr).to_s
  end
end