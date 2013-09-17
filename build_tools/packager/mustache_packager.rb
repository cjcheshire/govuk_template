require 'open3'
require 'govuk_template/version'
require 'packager/tar_packager'
require 'compiler/mustache_processor'

module Packager
  class MustachePackager < TarPackager
    def initialize
      super
      @base_name = "mustache_govuk_template-#{GovukTemplate::VERSION}"
    end

    def process_template(file)
      target_dir = @target_dir.join(File.dirname(file))
      target_dir.mkpath
      target_file = File.basename(file, File.extname(file)).sub(/\.html\z/, '.mustache') # /path/to/foo.html.erb -> foo.scala.html
      File.open(target_dir.join(target_file), 'wb') do |f|
        f.write Compiler::MustacheProcessor.new(file).process
      end
    end
  end
end
