require 'auto_mate'
require 'optparse' 
require 'erb'
require 'fileutils'

module AutoMate
  class Cli
    include FileUtils

    Directories = %w{something}

    attr_reader :options, :command, :arguments

     def initialize(arguments, stdin)
       @command = arguments[0]
       @arguments = arguments
     end

    def run  
      if valid_auto_mate_command?   
        @command = arguments.delete_at(0)
        process_command 
      else
        puts "Command not recognized."
      end
    end

    protected

    def valid_auto_mate_command?
      %w{remote setup -v}.include? @command
    end

    def process_command
        @command = "output_version" if command == "-v"
        send @command
    end

    def setup
      p "Welcome to setup"
    end

    def remote
      p "Run remote script"
    end
  end
end