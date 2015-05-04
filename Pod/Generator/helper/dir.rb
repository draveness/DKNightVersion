def find_xcodeproj(path)
    Dir.foreach(path) do |f|
        return File.join path, f if File.extname(f) == ".xcodeproj"
    end
    find_xcodeproj(File.join '..', path)
end

def find_pbxproj(path)
    xcodeproj = find_xcodeproj(path)
    Dir.foreach(xcodeproj) do |f|
        return File.join xcodeproj, f if File.extname(f) == ".pbxproj"
    end
end
