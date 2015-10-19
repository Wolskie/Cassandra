require 'fileutils'

BUILD_DIR = "./build"
APP_NAME  = "Cassandra"
COMPILER  = "valac"

DEBUG     = "--debug"
RELEASE   = "--disable-assert -v -X -s -X -O3"
CFLAGS    = "--thread -v "


CC_DEBUG   = "#{COMPILER} #{DEBUG}   #{CFLAGS} -o #{BUILD_DIR}/#{APP_NAME} "
CC_RELEASE = "#{COMPILER} #{RELEASE} #{CFLAGS} -o #{BUILD_DIR}/#{APP_NAME} "

# When compiling th`ese
# get included in the command
# line as --pkg <name
#
PKGS      = %w[
    libsoup-2.4
    json-glib-1.0
]

PKG_CONFIG = "PKG_CONFIG='pkg-config --libs --cflags libsoup-2.4 json-glib-1.0'"

# Other packages might need
# gee-1.0
# sqlite3

SOURCE    = %w[
   Collector/**/**/*.vala
]

task :default do
    puts "You should try one of these:\n"
    puts "rake build:<release|debug>"
    puts "rake clean"
end

task :clean do

    delete_temp_files()

    # Remove the build directory
    # as we dont need it anymore.
    #
    if Dir.exists? BUILD_DIR then
        FileUtils.rm_rf(BUILD_DIR);
    end

end

namespace :build do
    task :debug do
        exec(make_build_command(:debug))
    end

    task :release do
        exec(make_build_command(:release))
    end

end


def make_build_command(debug)
    @src  = " "
    @pkgs = " "
    cmd = ""

    SOURCE.each do |file|
        @src << Dir.glob(file).join(" ")
    end

    PKGS.each do |pkg|
        @pkgs << "--pkg #{pkg} "
    end

    if not Dir.exist?(BUILD_DIR) then
        Dir.mkdir(BUILD_DIR)
    end

    cmd = PKG_CONFIG

    if(debug == :debug) then
        cmd << " " << CC_DEBUG << @pkgs << @src
    else
        cmd <<  " " << CC_RELEASE << @pkgs << @src
    end
    
    return cmd

end


def delete_temp_files()

    # Delete backup files left by
    # some editors.
    #
    Dir.glob("./**/**/*.~", File::FNM_DOTMATCH).each do |f|
        File.unlink(f)
    end
    Dir.glob("./**/**/*.c", File::FNM_DOTMATCH).each do |f|
        File.unlink(f)
    end
    Dir.glob("./**/**/*.o", File::FNM_DOTMATCH).each do |f|
        File.unlink(f)
    end

end
