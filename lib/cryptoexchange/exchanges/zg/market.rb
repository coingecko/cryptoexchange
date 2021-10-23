module Cryptoexchange::Exchanges
  module Zg
    class Market < Cryptoexchange::Models::Market
      NAME = 'zg'
      API_URL = 'https://api.zg8.com/openapi/quote/v1'

      def self.trade_page_url(args={})
        "https://www.zg.com/exchange/737/#{args[:base]}/#{args[:target]}"
      end

      def self.separate_symbol(pair)
        separator = /(|USDT)\z/i =~ pair
        base      = pair[0..separator - 1]
        target    = pair[separator..-1]
        [base, target]
      rescue NoMethodError
        nil
      end
    end
  end
end


