require 'openssl'
require 'base64'
module UserzonesHelper
	def genpmk(pass, ssid, userzoneid)

		#pass = pass
		#ssid = ssid
		salt = OpenSSL::Random.random_bytes(16)
		digest = OpenSSL::Digest::SHA256.new
		len = digest.digest_length
		key = OpenSSL::PKCS5.pbkdf2_hmac_sha1(pass, ssid, 4096, len)
		atype = key.class
		puts "Key (type:#{atype}, len:#{key.length}) #{key}"
		chars = key.split('')
		print "PMK Hex key: "
		chars.each do |n|
			print "#{n.ord.to_s(16)}"
		end
		puts " "

		pmkey = Base64.encode64(key)
		puts "PMK Text Key: #{pmkey}"
		
		userzone = Userzone.find_by(id: userzoneid) 
		userzone.update(pmk: pmkey) 
		return 
	end 
end
