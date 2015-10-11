require 'fileutils'

BUILD_DIR = "./build"
APP_NAME  = "Cassandra"
COMPILER  = "valac"

CC = "#{COMPILER} -o #{BUILD_DIR}/#{APP_NAME} "

# When compiling th`ese
# get included in the command
# line as --pkg <name
#
PKGS      = %w[
    gee-1.0
    libsoup-2.4
    json-glib-1.0
    sqlite3
]

SOURCE    = %w[
   Collector/**/**/*.vala
]

task :default do
    puts "You should try one of these:\n"
    puts "rake build:<release|debug>"
    puts "rake clean"
end

task :clean do

    # Remove the build directory
    # as we dont need it anymore.
    #
    if Dir.exists? BUILD_DIR then
        FileUtils.rm_rf(BUILD_DIR);
    end

    # Delete backup files left by
    # some editors.
    #
    Dir.glob("./**/**/*.~", File::FNM_DOTMATCH).each do |f|
        File.unlink(f)
    end
    Dir.glob("./**/**/*.c", File::FNM_DOTMATCH).each do |f|
        File.unlink(f)
    end
end

namespace :build do
    task :debug do

        @src  = " "
        @pkgs = " "

        SOURCE.each do |file|
            @src << Dir.glob(file).join(" ")
        end

        PKGS.each do |pkg|
            @pkgs << "--pkg #{pkg} "
        end

        if not Dir.exist?(BUILD_DIR) then
            Dir.mkdir(BUILD_DIR)
        end

         cmd = CC << @pkgs << @src

         puts cmd; exec cmd

    end

    task :release do
        abort("Not ready")
    end

end
