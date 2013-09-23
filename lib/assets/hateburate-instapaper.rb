
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

      return false if point < @config['threshold'].to_i

      https = Net::HTTP.new('instapaper.com', '443')
      https.use_ssl = true
      res = https.start do |https|
        req = Net::HTTP::Post.new('https://www.instapaper.com/api/add')
        req.basic_auth @config['username'], @config['password']
        req.body =  "url=" + url
        res = https.request(req)
      end
      res.code.to_i == 201
    end
  end
end

