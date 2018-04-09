
require 'poi/opt'
require 'poi/constants'
require 'poi/utils'

require 'rubygems'
require 'fileutils'
require 'mustache'
require 'json'
require 'open-uri'


module POI
    class App
        include POI::Constants
        include POI::Utils

        def run(argv)
            @opt = POI::Opt.new
            @opt.parse(argv)
            dispatch(@opt.options)
        end

        def pack(options)
            target = options[:target] ? File.open(options[:target], "w") : STDOUT
                if (File.exists?(options[:pack]))
                    File.readlines(options[:pack]).map {|l| l.strip }.map {|l| Dir.glob(l)}.flatten
                        .tap {|fs| fs.insert(0, POI_DEFAULTS) if File.exists?(POI_DEFAULTS) and !fs.include?(POI_DEFAULTS)}
                        .select {|l| l != options[:target]}.each do |l|
                            file = l.strip
                            unless File.directory?(file)
                                puts "Packing #{file} ..." unless target == STDOUT
                                content = File.readlines(file) 
                                target.puts("#{file} #{content.size}")
                                target.puts(content.join) if (!content.empty?)
                                target.puts
                            end
                        end
                end
            target.print(".")
            puts "Done" unless target == STDOUT
            target.close unless target == STDOUT
        end

        def dispatch(options)
            if (options[:pack])
                pack(options)
            elsif (!options[:file])
                puts @opt.optparser if (!options[:help])
            else
                expand(options)
            end
        end

        def expand(options)
            lines = open(options[:file]).readlines
            data = {};
            x = 0;

            while lines[x].strip != '.' && x < lines.size do
                data = JSON.load(File.read(POI_DEFAULTS)) if File.exists? POI_DEFAULTS
                data.merge!(JSON.load(File.read(".poi_vars"))) if File.exists? ".poi_vars"
                line = lines[x].strip
                if (line =~ /^(.+)\s(\d+)$/)
                    file = $1.strip
                    size = $2.to_i
                    texts = lines[x+1, size]
                    parent = parents(file);
                    FileUtils.mkdir_p(parent)
                    if (options[:delete])
                        File.delete(file) if File.exists?(file)
                        puts "Deleting #{file} ..."
                        while (parent.size > 0 && Dir.open(parent).count <= 2 && parent != ".") do
                            Dir.delete(parent)
                            puts "Deleting #{parent} ..."
                            parent = parents(parent)
                        end
                    else
                        File.open(file, "w") do |f|
                            puts "Generating #{file} ..."
                            f << Mustache.render(texts.join, data)
                        end
                    end
                    x += size
                end
                x += 1
            end
            puts "Done!"
        end

    end
end