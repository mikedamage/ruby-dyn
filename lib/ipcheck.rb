class IPCheck
	include HTTParty
	
	base_uri "http://checkip.dyndns.org"
	format :xml
	
	def self.check_ip
		i = self.get_html
		return i["html"]["body"].slice(/\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/)
	end
	
	def self.get_html
		get("/")
	end
end