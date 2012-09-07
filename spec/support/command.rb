module SpecRig
  class Command
    def initialize(*args)
      @args = args
      @working_dir = nil
    end

    def in_directory(dir)
      Command.new(*@args).tap do |c|
        c.working_dir = dir
      end
    end

    def to_s
      @args.join ' '
    end

    def inspect
      "Command(#{self})"
    end

    def successful?
      result.status.success?
    end

    def output
      result.output
    end

    def status
      result.status.exitstatus
    end

    def run_successfully
      raise "#{inspect} failed:\n#{output}" unless successful?
    end

    def result
      @result ||= begin
        Dir.chdir(working_dir || Dir.pwd) do
          output = `#{self} 2>&1`
          Result.new output, $?
        end
      end
    end

    protected

    attr_accessor :working_dir

    class Result
      attr_reader :output, :status
      def initialize(output, status)
        @output, @status = output, status
      end
    end
  end
end

RSpec::Matchers.define :be_successful do 
  match { |command| command.successful? }

  failure_message_for_should do |command|
    "Expected #{command.inspect} to succeed, but failed with status: #{command.status} and output:\n#{command.output}"
  end
end

RSpec::Matchers.define :have_exit_code do |code|
  match { |command| command.status == code }

  failure_message_for_should do |command|
    "Expected #{command.inspect} to have status #{code}, but exited with status: #{command.status} and output:\n#{command.output}"
  end
end

