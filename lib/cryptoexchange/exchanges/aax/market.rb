module Cryptoexchange::Exchanges
  module Aax
    class Market < Cryptoexchange::Models::Market
      NAME = 'aax'
      API_URL = 'https://api.aax.com/marketdata/v1.1'

      def self.trade_page_url(args={})
        "https://www.aax.com/spot/trade/#{args[:base]}:#{args[:target]}"
      end

      def self.separate_symbol(pair)
        separator = /(USDT|BTC|ETH)\z/i =~ pair
        base      = pair[0..separator - 1]
        target    = pair[separator..-1]
        [base, target]
      rescue NoMethodError
        nil
      end      
    end
  end
end
