require "rubygems"
require "httparty"
require File.join(File.dirname(__FILE__), "ipcheck.rb")

class DynDNS
	include HTTParty
	attr_accessor :hostname, :username, :password, :external_ip
	base_uri "http://members.dyndns.org"
	headers 'User-Agent' => "RubyDynDNS"
	
	@@update_opts = {
		:wildcard => "NOCHG",
		:mx => "NOCHG",
		:backmx => "NOCHG"
	}
	
	def initialize(hostname, username, password, options={})
		@hostname = hostname
		@username = username
		@password = password
		@external_ip = IPCheck.check_ip
		@options = @@update_opts.merge(options).merge({:hostname => @hostname})
		self.class.basic_auth(@username, @password)
	end
	
	def update_dns
		self.class.get("/nic/update", :query => @options)
	end
end