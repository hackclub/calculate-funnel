require 'io/console'

module Util
  # Gets user input from console, but hides what they're typing.
  #
  # See http://stackoverflow.com/a/11765329 for source.
  def self.gets_hidden
    STDIN.noecho(&:gets)
  end
end
