require 'open-uri'
require 'openssl'

def every seconds, &block
  while true
    yield
    sleep seconds
  end
end

url = 'https://internal.nulogy.net/trac/engineering/report/38?format=csv&USER=XXX'
options = {
    :http_basic_authentication => ["XXX", "XXX"],
    :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE}

DEV = 1
STABLE = 2
PERCENT_TARGET = 7
NUMBER_FORMAT = "%3.2f%"

every 5 do
  open(url, options) do |page|
    lines = page.readlines.map {|l| l.split ','  }
    dev = lines[DEV][PERCENT_TARGET]
    stable = lines[STABLE][PERCENT_TARGET]
    puts "Current DEV burndown: #{sprintf NUMBER_FORMAT, dev}"
    puts "Current STABLE burndown: #{sprintf NUMBER_FORMAT, stable}"
  end
end

