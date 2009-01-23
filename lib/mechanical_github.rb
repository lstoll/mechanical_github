# 
# automates the creation of a git repository on github.
require 'rubygems'
require 'mechanize'

module MechanicalGithub
  VERSION="0.2.0"
end

# load all files
Dir["#{File.join(File.dirname(__FILE__), "mechanical_github")}/*.rb"].each { |file| require(file) }