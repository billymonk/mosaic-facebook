# $:.push File.expand_path("../lib", __FILE__)
# require 'httparty'
# require 'lib/mosaic_facebook'

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

# SPEC_DIR = File.dirname(__FILE__)
# lib_path = File.expand_path("#{SPEC_DIR}/../lib")
# $LOAD_PATH.unshift lib_path unless $LOAD_PATH.include?(lib_path)

require 'mosaic_facebook'