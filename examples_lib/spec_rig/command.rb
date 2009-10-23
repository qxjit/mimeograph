module SpecRig
  class Command
    def initialize(*args)
      @args = args
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

    def run_successfully
      raise "#{inspect} failed:\n#{output}" unless successful?
    end

    def result
      @result ||= begin
        output = `#{self} 2>&1`
        Result.new output, $?
      end
    end

    class Result
      attr_reader :output, :status
      def initialize(output, status)
        @output, @status = output, status
      end
    end
  end
end

Spec::Matchers.define :be_successful do 
  match { |command| command.successful? }

  failure_message_for_should do |command|
    "Expected #{command.inspect} to succeed, but failed with output:\n#{command.output}"
  end
end

