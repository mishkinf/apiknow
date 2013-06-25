#!/usr/bin/env ruby
$:.push '.'

require 'rake'
require File.dirname(__FILE__) + '/server'

API_REQUEST_BASE = 'http://127.0.0.1:3333/'

# Create any test database needed
# Initialize Test Fixtures
# Spawn any servers are are needed to run the API

require 'open3'

buffer = []
exit_code = 0
Open3::popen3("rake spec") do |stdin,stdout,stderr, wait_thread|
  begin
    while line = stdout.readline
      buffer << line
    end
  rescue
  end
  exit_code = wait_thread.value.exitstatus
end

puts buffer
exit exit_code
