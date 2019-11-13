module Cryptoexchange::Exchanges
  module Basefex
    class Market < Cryptoexchange::Models::Market
      NAME = 'basefex'
      API_URL = 'https://api.basefex.com'

      def self.trade_page_url(args={})
        "https://www.basefex.com/trade/#{args[:inst_id].upcase}"
      end

      def self.separate_symbol(pair)
          separator = /(XBT|USDT|USD|BTC|ETH|XRP|BCH|LTC|BNB)\z/i =~ pair
          base      = pair[0..separator - 1]
          target    = pair[separator..-1]
          [base, target]
        rescue NoMethodError
          nil
      end
    end
  end
end
