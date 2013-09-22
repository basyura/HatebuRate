
require 'net/https'
require 'yaml'

module HatebuRate
  #
  #
  class Instapaper

    #
    #
    def initialize
      @config = YAML::load(IO.read("config/instapaper.yml"))
    end

    #
    #
    def add(point, url)

      return if point < @config['threshold'].to_i

      https = Net::HTTP.new('instapaper.com', '443')
      https.use_ssl = true
      https.start do |https|
        req = Net::HTTP::Post.new('https://www.instapaper.com/api/add')
        req.basic_auth @config['username'], @config['password']
        req.body =  "url=" + url
        res = https.request(req)
        res
      end
    end
  end
end

