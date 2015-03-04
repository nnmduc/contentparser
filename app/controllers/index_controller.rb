class IndexController < ApplicationController
	skip_before_action :verify_authenticity_token

	def index
	end

	def show
		require 'nokogiri'
		require 'open-uri'
		pageUrl = params[:url]
		# Fetch and parse HTML document
		doc = Nokogiri::HTML(open(pageUrl))

		body = doc.css('div#abody')
		body.xpath('//@style').remove
		body.css('div').each do |div|
			if div.content == ''
				div.remove
			else
				img = div.css('img')
				if img.count == 0
					div.name = 'p'
				end
			end
		end

		@content = body.inner_html
	end
end