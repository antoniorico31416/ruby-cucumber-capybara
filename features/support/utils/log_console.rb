class LogPrint

    def initialize()
    end

    def log(value, color = :green)
        case color
          when :green
            puts "#{value}".green
          when :blue
            puts "#{value}".blue
          when :yellow
            puts "#{value}".yellow
          when :red
            puts "#{value}".red
          when :magenta
            puts "#{value}".magenta
          when :white
            puts "#{value}".white
          else
            puts "#{value}".green
        end
    end

end