# ~/.pryrc

# Monitor time usage.
pryrc_start_time = Time.now

require '~/.pryrc-helpers'

# Avoid naming conflicts.
_ = PryrcHelpers
_daily_gems = %w[benchmark yaml json sqlite3]

# Unsupported with 2.2.x: debugger, pry-debugger - Keep as a TODO.
_pry_gems = %w[awesome_print hirb sketches pry-stack_explorer]

_daily_gems._require_gems
_pry_gems._require_gems

if defined? Hirb
  # Horrible implementation to support in-session Hirb.disable/enable toggling
  Hirb::View.instance_eval do
    def enable_output_method
      @output_method = true
      @old_print = Pry.config.print
      Pry.config.print = proc do |output, value|
        Hirb::View.view_or_page_output(value) || @old_print.call(output, value)
      end
    end

    def disable_output_method
      Pry.config.print = @old_print
      @output_method = nil
    end
  end

  Hirb.enable
end

# Awesome Print
if defined? AwesomePrint
  AwesomePrint.pry!
  Pry.config.print = proc {|output, value| Pry::Helpers::BaseHelpers.stagger_output("=> #{value.ai(indent: 2)}", output)}

  ## if in bundler, break out, so awesome print doesn't have to be in Gemfile.
  if defined? Bundler
    Gem.post_reset_hooks.reject! { |hook| hook.source_location.first =~ %r{/bundler/} }
    Gem::Specification.reset
    load 'rubygems/custom_require.rb'
  end

  ## awesome_print config for Minitest.
  if defined? Minitest
    module Minitest::Assertions
      def mu_pp(obj)
        obj.awesome_inspect
      end
    end
  end
end

# Pry Configurations

# Consistency is a good thing.
Pry.config.history.file = "~/.irb_history"

Pry.config.editor = "emacs"
Pry.config.prompt = proc do |obj, level, _|
  prompt = ""
  prompt << "AWS@" if defined?(AWS)
  prompt << "#{Rails.version}@" if defined?(Rails)
  prompt << "#{RUBY_VERSION}"
  "~> "
end

# Exceptions

Pry.config.exception_handler = proc do |output, exception, _|
  puts _.colorize "#{exception.class}: #{exception.message}", 31
  puts _.colorize "from #{exception.backtrace.first}", 31
end

# Handy hotkeys for debugging.

if defined?(PryDebugger)
  Pry.config.commands.alias_command 'c', 'continue'
  Pry.config.commands.alias_command 's', 'step'
  Pry.config.commands.alias_command 'n', 'next'
  Pry.config.commands.alias_command 'f', 'finish'
end

# Customized hotkeys for Pry

# Ever get lost in pryland? try w!
Pry.config.commands.alias_command 'w', 'whereami'

# Clear Screen
Pry.config.commands.alias_command '.clr', '.clear'

# Customized hotkeys for Ruby

# You may quickly define a variable like r or l in REPL
# Then you lose these aliases, so take care!
alias :r :require
alias :l :load

# Because we all love pbcopy.

# options : -m : Multiline copy
# Usage :
#         a => [1, 2, 3]
#         pbcopy
#         [1, 2, 3]
#         pbcopy -m
#          [
#           1,
#           2,
#           3,
#          ]

if RUBY_PLATFORM =~ /darwin/i # OSX only.
  # The pbcopy manual page for Mac OS X
  # http://ln.rmfr.org/_pbcopy
  def pbcopy(str, opts = {})
    IO.popen('pbcopy', 'r+') { |io| io.print str }
  end

  Pry.config.commands.command "pbcopy", "Copy last returned object to clipboard, -m for multiline copy" do

    multiline = arg_string == '-m'
    pbcopy _pry_.last_result.ai(:plain => true,
                                :indent => 2,
                                :index => false,
                                :multiline => multiline)
    output.puts "Copied #{multiline ? 'multilined' : ''}!"
  end

  Pry.config.commands.alias_command 'cp', 'pbcopy'
end

# Rails

if defined?(Rails)
  begin
    require "rails/console/app"
    require "rails/console/helpers"
  rescue LoadError => e
    require "console_app"
    require "console_with_helpers"
  end
end

# Initialisation.

Pry.active_sessions = 0

Pry.config.hooks.add_hook(:before_session, :welcome) do
    if Pry.active_sessions.zero?
      print _.colorize "Initialising #{RUBY_VERSION}-p#{RUBY_PATCHLEVEL} ", 35
      sleep(0.3); print("."); sleep(0.3); print(".");   sleep(0.3); print(". ");
      puts _.colorize "Ready!", 34
      puts _.welcome_messages
    end
  Pry.active_sessions += 1
end

Pry.config.hooks.add_hook(:after_session, :farewell) do
  Pry.active_sessions -= 1
end
