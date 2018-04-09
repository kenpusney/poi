
require 'poi/app'
require 'optparse'

module POI
    class Pois
        def run(argv)
            options  = []
            OptionParser.new do |opts|
                opts.banner = "Usage: pois -f [host poi] [-d]"
                opts.on('-f', '--file FILE / URL', 'Generate using .poi file.') do |file|
                    options << "-f"
                    options << "https://raw.githubusercontent.com/poi-templates/pois/master/#{file.strip}.poi"
                end
            
                opts.on('-d', '--delete', 'Delete all generated file') do 
                    options << "-d"
                end
                
                opts.on('-h', '--help', "Print help message") do 
                    puts opts
                    exit
                end
            end.parse!(argv)
            
            POI::App.new.run(options)
        end
    end
end