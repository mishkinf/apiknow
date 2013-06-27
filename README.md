# ApiKnow
*Quickly test an API and generate API documentation.*

##### Writing tests
Add a YAML file in routes folder(see existing). Add a response JSON or whatever file in spec/responses.

```yaml
# Example YAML based DSL for specifying routes, parameters, descriptions and test files
videos:
  - :path: /feeds/api/videos/3aICB2mUu2k
    :description: This route is used to get information about a youtube video details
    :method: :get
    :required_params:
        - :name: v
          :example_value: 2
          :description: Version of the API
    :optional_params:
        - :name: alt
          :example_value: json
          :description: specifies the format desitred
```

##### Running the tests
```bash
>> rake spec
Creating test database (if necessary)
Initializing test database with test data (if necessary)
Spawning api server (if necessary)
/Users/mfaustini/.rvm/rubies/ruby-1.9.2-p290/bin/ruby -S rspec -fs --color ./spec/api/test_resources_spec.rb

******************* VIDEOS RESOURCE ROUTES *******************
  ROUTE: GET /feeds/api/videos/3aICB2mUu2k
    When navigating to the base route
GET http://gdata.youtube.com/feeds/api/videos/3aICB2mUu2k?v=2
      should respond with a 200
    When navigating to the route with optional parameter query alt=json
GET http://gdata.youtube.com/feeds/api/videos/3aICB2mUu2k?alt=json&v=2
      should response with a 200

Finished in 0.75199 seconds
2 examples, 0 failures
No examples matching ./spec/responses/**/*_spec.rb could be found
```
##### Running ApiKnow in interactive console
```bash
>> ./apitestconsole
```

##### Generating Documenation
Documentation is generated in 4 different formats: text, confluence, media wiki, and unstyled semantic html.

```bash
>> rake generate_docs
tmp/documentation.confluence generated.
tmp/documentation.html generated.
tmp/documentation.txt generated.
tmp/documentation.wiki generated.
```
documentation.txt example
```text
------------------------------------------------
My API
================================================
_Note: This API documentation is automagically generated_
   
********************************************************************
* GET /feeds/api/videos/3aICB2mUu2k
********************************************************************

* Description
-----------
This route is used to get information about a youtube video details

Required Parameters
+------------+---------------+--------------------+
| Param Name | Example Value |    Description     |
+------------+---------------+--------------------+
| v          | 2             | Version of the API |
+------------+---------------+--------------------+

Optional Parameters
+------------+---------------+-------------------------------+
| Param Name | Example Value |          Description          |
+------------+---------------+-------------------------------+
| alt        | json          | specifies the format desitred |
+------------+---------------+-------------------------------+

Example Requests
----------------
/feeds/api/videos/3aICB2mUu2k?v=2 - http://gdata.youtube.com//feeds/api/videos/3aICB2mUu2k?v=2

Example Output
--------------
No example output
```

Run honorable tests for great justice.

#### License

The MIT License Copyright (c) 2013 TrueCar, Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
TY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
