# -*- coding: utf-8 -*-
require 'net/http'
require 'nokogiri'

def noko_html(url)
  uri = URI.parse(url)
  body = Net::HTTP.get(uri)
  Nokogiri::HTML(body)
end

def parse_list(url)
  html = noko_html(url)
  html.css('.g h2 a').each do |el|
    yield el.text, el['href'] if el.text != ''
  end
end

def parse_link(url)
  html = noko_html(url)
  html.css('#result p').each do |el|
    yield el.text.gsub('磁力链接: ', '') if el.text.include?('magnet:')
  end
end

def search(query)
  url = "http://www.btkiki.com/s/#{query}.html"

  results = []
  parse_list(url) do |title, url_link|
    parse_link url_link do |resource_link|
      results << format('%s %s', title, resource_link)
    end
  end
  puts results.join("\n")
end


search(ENV['POPCLIP_TEXT'] || ARGV[0])

