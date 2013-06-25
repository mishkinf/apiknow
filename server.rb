#!/usr/bin/env ruby
require 'socket'

module Servers
  module_function
  def server(name, port)
    log "#{__FILE__}:#{__LINE__}: Starting #{name} server for integration test on port #{port}"

    pid=yield

    at_exit do
      log "Stopping #{name} server on port #{port}, pid: #{pid}"
      Process.kill("KILL", pid)
    end

    300.downto(0) do |i|
      begin
        TCPSocket.new('localhost', port).close
        break
      rescue Errno::ECONNREFUSED
        raise("Not able to start #{name} server on #{port}") if i == 0 or Process.wait pid, Process::WNOHANG
        sleep 1
      end
    end

    log "Started #{name} server on port #{port}, pid: #{pid}"
  end

  def cbapi server_dir='/tmp/cb-api-server', port='3333', environment='cbapiintegrationtest', git_reset=/\A\/tmp/===server_dir
    if ENV["DO_NOT_SPAWN_CBAPI"]
      check_server "CBAPI", 'localhost', port
      return
    end
    if ENV['DO_NOT_PULL_CBAPI']
      puts "not pulling/cloning cb-api-server"
    else
      if File.exist? server_dir
        system "git", "reset", "--hard", chdir: server_dir if git_reset
        system "git", "pull", chdir: server_dir
      else
        require 'fileutils'
        parent=File.dirname server_dir
        FileUtils.mkdir_p parent
        system "git", "clone", "git://git.truecarcorp.com/clear-book/cb-api-server.git", chdir: parent
      end
    end
    padrino environment + " CBAPI", server_dir, environment, port
  end

  def padrino(name, server_dir, environment, port, bundle='bundle check || bundle install --local')
    server(name, port) do
      bundle and bundle="{ gem install bundler -v 1.0.21 && #{bundle} ; } &&"
      bundle = '' if ENV['DO_NOT_BUNDLE']
      Process.spawn(
        {"BUNDLE_BIN_PATH" => nil, "BUNDLE_GEMFILE" => nil,
         "GEM_HOME" => nil, "GEM_PATH" => nil,
         "RUBYOPT" => nil, "RUBY_VERSION" => nil,
         "PADRINO_ENV" => environment,
         "CLEARBOOK_DB_NAME" => "cbapiintegrationtest_test",
         "CLEARBOOK_DB_HOST" => "localhost"
        },
        "/bin/bash --login -c 'cd #{server_dir} && source $rvm_path/scripts/rvm && source .rvmrc ; export CLEARBOOK_DB_NAME='cbapiintegrationtest_test' && #{bundle} exec padrino start -e #{environment} -p #{port}'"
      )
    end
  end

  def check_server(name, host, port)
    log "Checking if #{name} already running on #{host} port #{port}"
    begin
      TCPSocket.new(host, port).close
    rescue Errno::ECONNREFUSED => e
      e.msg<<" Not able to see #{name} on #{host} port #{port}"
      raise
    end
    log "Looks like #{name} is available at #{host} #{port}"
  end

  def log msg
    STDERR.puts msg
  end

end

