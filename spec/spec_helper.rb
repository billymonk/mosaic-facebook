# $:.push File.expand_path("../lib", __FILE__)
# require 'httparty'
# require 'lib/mosaic_facebook'

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)

SPEC_DIR = File.dirname(__FILE__)
# lib_path = File.expand_path("#{SPEC_DIR}/../lib")
# $LOAD_PATH.unshift lib_path unless $LOAD_PATH.include?(lib_path)

require 'mosaic-facebook'
FACEBOOK_CONFIG = YAML.load(File.open("#{SPEC_DIR}/facebook_config.yml", 'r'))

RSpec.configure do |config|
  config.add_setting :access_token, :default => FACEBOOK_CONFIG["access_token"]
  config.add_setting :user_id, :default => FACEBOOK_CONFIG["user_id"]
  config.add_setting :page_id, :default => FACEBOOK_CONFIG["page_id"]
  config.add_setting :app_id, :default => FACEBOOK_CONFIG["app_id"]
  config.add_setting :app_secret, :default => FACEBOOK_CONFIG["app_secret"]
end
