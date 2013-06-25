# ApiKnow
#### ApiKnow provides you with the ability to quickly test an API and generate API documentation.

##### GUIDELINES for testing

##### Unversioned APIs
After making any modifications, always add a test and never remove test coverage.
This approach will ensure backwards compatibility.

##### Versioned APIs
WIP

##### Running the tests
```bash
>> ruby run_tests.rb
```
##### Running the CbApiIntegrationTest interactive console
```bash
>> ./apitestconsole
```

##### Generating Documenation
```bash
>> rake generate_docs
```

##### Adding tests / end-points
Add a YAML file in routes (see existing). Add a response JSON or whatever file in spec/responses.

##### Running tests from Jenkins/Hudson/CI server
##### Mac/linux/unix
  The tests are easily runnable via any continuous integration server by simply running the 'ci.sh'
  file from your CI server for bash environments.

##### Windows
  (Coming soon)

Run honorable tests for great justice.

#### License

The MIT License Copyright (c) 2013 TrueCar, Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
TY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
