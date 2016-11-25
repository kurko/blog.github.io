require 'pry'

# This Plugin moves images from `_posts/images/**.*` over to
# `_site/images/**/*`. With that we're able to use iA Writer and have relative
# paths, which enables it to preview images correctly.
#
# Plus, we separate posts images from layout images.
module PostImages
  class Generator < Jekyll::Generator
    def generate(site)
      Dir.glob("_posts/images/**/*") do |file|
        if File.file?(file)
          path = file.split("/")
          dir = path[0..-2].join("/")
          file = path[-1]
          static_file = PostImages::StaticFile.new(site, site.source, dir, file)
          static_file.write("_site/images")
          site.static_files << static_file
        end
      end
    end
  end

  class StaticFile < Jekyll::StaticFile
    def destination(dest)
      super.gsub("_posts/", "")
    end
  end
end
