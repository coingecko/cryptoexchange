module Cryptoexchange::Exchanges
  module Chiliz
    class Market < Cryptoexchange::Models::Market
      NAME    = 'chiliz'
      API_URL = 'https://api.chiliz.net/openapi/quote/v1'

      def self.trade_page_url(args={})
        "https://www.chiliz.net/exchange/713/#{args[:base]}/#{args[:target]}"
      end

      def self.separate_symbol(pair)
        separator = /(|CHZ)\z/i =~ pair
        base      = pair[0..separator - 1]
        target    = pair[separator..-1]
        [base, target]
      rescue NoMethodError
        nil
      end
    end
  end
end
