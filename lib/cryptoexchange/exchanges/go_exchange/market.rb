module Cryptoexchange::Exchanges
  module GoExchange
    class Market < Cryptoexchange::Models::Market
      NAME    = 'go_exchange'
      API_URL = 'https://api.go.exchange'

      def self.trade_page_url(args={})
        "https://trade.go.exchange/en/trade/#{args[:base].upcase}#{args[:target].upcase}"
      end

      def self.separate_symbol(pair)
        separator = /(BCH|BTC|ETH|LTC|OMG|USDC|DAI)\z/i =~ pair
        base      = pair[0..separator - 1]
        target    = pair[separator..-1]
        [base, target]
      rescue NoMethodError
        nil
      end            
    end
  end
end
