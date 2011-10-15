#!/usr/bin/ruby

VIMRC = File.expand_path "~/.vimrc"
VIMRUNTIME = File.expand_path "~/.vim"

class Array
  def shell_s
    cp = dup
    first = cp.shift
    cp.map{ |arg| arg.gsub " ", "\\ " }.unshift(first) * " "
  end
end

def system *args
  abort "Failed during: #{args.shell_s}" unless Kernel.system *args
end

abort "~/.vimrc already exists" if File.exist? VIMRC
abort "#{VIMRUNTIME}/vimrc already exists" if File.exist? VIMRUNTIME
if File.exist?(VIMRUNTIME)
  abort "#{VIMRUNTIME} already exists" unless Dir["#{VIMRUNTIME}/*].empty?
end

system "git clone git://github.com/pinhoramic/vimrc.git #{$VIMHOME}"

Dir.chdir VIMHOME
system "git submodule update --init"

Dir.chdir ".."
system "ln -s .vim/vimrc .vimrc"
system "ln -s .vim/gvimrc .gvimrc"

Dir.chdir "#{VIMRUNTIME}/bundle/command-t/ruby/command-t"
require "extconf.rb"
system "make"
