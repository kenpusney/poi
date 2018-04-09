require 'optparse'

module POI
    class Opt
        attr_reader :options, :optparser
        def initialize
            @options = {}
            @optparser = OptionParser.new do |opts|

                opts.banner = "Usage: poi -f [FILE / URL] [-d]"
            
                opts.on('-f', '--file FILE / URL', 'Generate using .poi file.') do |file|
                    @options[:file] = file
                end
            
                opts.on('-d', '--delete', 'Delete all generated file') do 
                    @options[:delete] = true
                end
            
                opts.on('-p', '--pack [PACK]', 'Pack .poipack file into .poi') do |pack|
                    @options[:pack] = pack || '.poipack'
                end
            
                opts.on('-t', '--target TARGET', 'Packaging target') do |target|
                    @options[:target] = target
                end
            
                opts.on('-h', '--help', "Print help message") do 
                    @options[:help] = true
                    puts opts
                    exit
                end
            end
        end

        def parse(argv)
            @optparser.parse!(argv)
        end

    end
end