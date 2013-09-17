require 'thor'
require 'profess/commands/new'

module Profess

  class CLI < Thor
    
  register(Profess::New, "new", "new [project|deck]", "Used to generate projects and slide decks")

  end

end

Profess::CLI.start(ARGV)

