require 'rubygems'
require 'bundler'

require 'blacklight/engine'
require 'rsolr'
require 'rsolr-ext'
Bundler.require :default, :development

Combustion.initialize!
run Combustion::Application
