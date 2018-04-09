module POI
    module Utils
        def parents(path)
            segs = path.split("/")
            parent_segs = segs[0...-1];
    
            if (parent_segs.empty?)
                return "."
            end
            return parent_segs.join("/")
        end
    end
end