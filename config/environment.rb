# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'development'

require 'dotenv/load'
Dotenv.load(".env.#{ENV['RACK_ENV']}")

require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])

dev = ENV['RACK_ENV'] == 'development'

if dev
  require 'logger'
  logger = Logger.new($stdout)
end

Unreloader = Rack::Unreloader.new(subclasses: %w[Roda Sequel::Model], logger: logger, reload: dev) do
  SequelSequenceDemo
end

require_relative 'application_loader'
ApplicationLoader.load_app!

Unreloader.require('config/application.rb') { 'SequelSequenceDemo' }
