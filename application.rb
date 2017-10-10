require 'httparty'
require 'nokogiri'

tickers = [
	'FB',
	'GOOGL',
	'AAPL',
	'TSLA',
	'KO'
]

prices = []

def get_mgmt(ticker)
	ticker = "aapl"
	tag = 'table#id-mgmt-table tr td.p'
	url = "https://finance.google.com/finance"
	q_string = "?q=#{ticker}"
	response = HTTParty.get(url + q_string)
	parsed = Nokogiri::HTML(response.body)
	person = parsed.css(tag).text.to_f
	

end

def get_price(ticker)
	h = Hash.new
	url = "https://finance.google.com/finance"
	q_string = "?q=#{ticker}"
	response = HTTParty.get(url + q_string)
	parsed = Nokogiri::HTML(response.body)
	price = parsed.css('span.pr').text.to_f
	puts "#{ticker} @ #{price}"
	h[ticker] = price
	return h
end

for stock_symbol in tickers
	prices << get_price(stock_symbol)
end

puts prices

