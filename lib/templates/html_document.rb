require_relative '../document'
require 'json'

class HtmlDocument < Document
  def generate
    <<-DOC
      <html>
      <head>#{header}</head>

      <body>
      #{table_of_contents}
      #{
        @resources.map do |resource|
          resource.routes.map do |r|
            route_section r
          end
        end.flatten.join
      }
      </body>
      </html>
    DOC
  end

  def header
    <<-END
       <h1><My API</h1>
       <h5>_Note: This API documentation is automagically generated</h5>
   END
  end

  def table_of_contents
    <<-TOC
      Table of Contents

    TOC
  end

  def route_section(route)
    required = parameter_table(route.required_params)
    optional = parameter_table(route.optional_params)

    <<-END
      <h2>#{route.http_method} #{route.path}</h2>
      <p>#{route.description}</p>

      #{"<h3>Required Parameters</h3><div class='required_params'>#{required}</div>" if required}
      #{"<h3>Optional Parameters</h3><div class='optional_params'>#{optional}</div>" if optional}

      <h3>Example Requests</h3>
      <div class='example_request'>#{example_requests(route)}</div>

      <h3>Example Output</h3>
      <div class='example_output'>#{example_output(route)}</div>

    END
  end

  def example_requests(route)
    path_with_params = route.path_with_params

    host = "http://mishkinfaustini.com/"
    url = host + path_with_params

    "<a href='#{url}'>#{path_with_params}</a>"
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
    <<-TABLE
      <table>
        <tr>
          <th>Param Name</th>
          <th>Example Value</th>
          <th>Description</th>
        </tr>

      #{
      if params
        params.map do |p|
          "<tr>
                    <td>#{p.name}</td>
                    <td>#{p.example_value}</td>
                    <td>#{p.description}</td>
                  </tr>"
        end.join('')
      end
      }
      </table>
    TABLE
  end
end