module Cryptoexchange::Exchanges
  module Xcoex
    class Market < Cryptoexchange::Models::Market
      NAME = 'xcoex'
      API_URL = 'https://live.xcoex.com:8443/api/v1/public'

      def self.trade_page_url(args={})
        "https://app.xcoex.com"
      end

      def self.separate_symbol(pair)
        separator = /(BTC|ETH|USD|USDC|EUR|USDT)\z/i =~ pair
        base      = pair[0..separator - 1]
        target    = pair[separator..-1]
        [base, target]
      rescue NoMethodError
        nil
      end      
    end
  end
end
