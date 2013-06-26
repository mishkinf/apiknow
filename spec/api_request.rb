require 'curb'
require 'uri'

API_REQUEST_BASE = 'http://gdata.youtube.com/'

def api_request(route, params)
  method = route.http_method

  query_params = []
  post_params = []

  params.each do |p|
    query_params << p if p.type == :query
    post_params << p if p.type == :post
  end

  query_params = query_params.flatten.compact
  post_param = post_params.flatten.compact

  url_string = URI.join(API_REQUEST_BASE, route.path, route.make_query_string(query_params)).to_s
  case method
    when :get
      puts "GET #{url_string}"
      result = Curl.get url_string
    when :post
      puts "POST #{url_string}"
      puts "PARAMS: #{post_params.inspect}"
      post_param = post_params.first.example_value
      result = Curl.post url_string, post_param
    else
      raise NotImplementedError.new "Unimplemented HTTP method: #{method.to_s}"
  end

  # TODO: Take out any unnecessary debugging cruft
  #puts result.status
  if result.status.to_i >= 400
    return result.status.to_i,
    {
      meta: {
        status: 'error',
        message: result.body_str
      }
    }
  else
    return result.status.to_i, result.body_str
  end
end
