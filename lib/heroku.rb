require 'open3'

require_relative './util'

class Heroku
  # Will return false if not logged in
  def self.authed?
    system(
      'heroku', 'auth:token',
      out: File::NULL, # send output to /dev/null
      err: File::NULL, # send stderr to /dev/null
    )
  end

  # Logs in Heroku CLI client
  def self.login(email, password)
    system(
      # run ./bin/heroku_login to log into Heroku
      File.join(File.dirname(__FILE__), 'bin', 'heroku_login'), email, password,
      out: File::NULL # send output to /dev/null
    )
  end

  def self.login_interactive
    puts "Logging into Heroku..."
    print "Email: "
    email = gets.strip
    print "Password: "
    password = Util.gets_hidden.strip
    print "\n" # gets_hidden drops extra newline, need to print it ourselves

    puts "Attempting login..."

    if self.login(email, password)
      true
    else
      false
    end
  end

  # Runs a command in a Heroku app and returns stdout
  def self.run_cmd(cmd, app)
    stdout, _stderr, _status = Open3.capture3('heroku', 'run', cmd, '--app', app)
    stdout.force_encoding('utf-8') # it returns us-ascii, convert to utf-8 so we can actually use it
  end
end
