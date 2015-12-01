require 'curb'

d2l_url = 'https://elearningdev.test.wmich.edu/'

auth = Curl::Easy.new("#{d2l_url}") { |http|
	http.headers['connection'] = 'close'
	http.verbose = true
}

auth.ssl_verify_peer = false
auth.perform

puts auth.body_str
