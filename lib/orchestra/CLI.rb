require 'trollop'

class CLI

  def self.parse

    options = Trollop::options do
  
      version "orchestra 1.0"
      banner <<-EOS
Orchestra is a platform-wide automated deployment orchestration tool. 

      EOS
     
      opt :quiet, "Less verbose output", :short => 'q'
      opt :dryrun, "Dry run, dont actually do anything", :short => 'n'
      opt :listtasks, "List tasks", :short => 'l'

    end

    return { :options => options, :tasks => ARGV }
  
  end

end
