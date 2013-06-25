require 'resources'
require 'spec_helper'

resources = Resources.load
resources.each do |resource|
  describe "******************* #{resource.name.to_s.upcase} RESOURCE ROUTES *******************" do
    def perform_test(route, optional_params=nil)
      options = {}

      params = [].push(optional_params).push(route.required_params).flatten.compact

      @status_code, @body = api_request route, params

      #expected_response = get_response()

      #@status_code.should == 200
      #body.should == expected_response
    end

    resource.routes.each do |route|
      context "ROUTE: #{route.http_method.to_s.upcase} #{route.path}", route: route do
        describe "When navigating to the base route", route: route do
          before(:all) do
            perform_test route
          end

          it "should respond with a 200", route: route do
            @status_code.should == 200
          end

          if route.test_file
            it "should match the expected response located in '#{route.test_file}'", route: route do
              @body.should == get_response(route.test_file)
            end
          end
        end

        if route.optional_params
          route.optional_params.each do |param|
            describe "When navigating to the route with optional parameter #{param}", route: route do
              before(:all) do
                perform_test route, [param]
              end

              it "should response with a 200", route: route do
                @status_code.should == 200
              end

              if param.test_file
                it "should match the expected response located in '#{param.test_file}'", route: route do
                  @body.should == get_response(param.test_file)
                end
              end
            end
          end
        end
      end
    end
  end
end
