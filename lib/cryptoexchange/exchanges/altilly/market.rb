module Cryptoexchange::Exchanges
  module Altilly
    class Market < Cryptoexchange::Models::Market
      NAME = 'altilly'
      API_URL = 'https://api.altilly.com/api'

      def self.trade_page_url(args = {})
        "https://www.altilly.com/market/#{args[:base]}_#{args[:target]}"
      end

      def self.separate_symbol(pair)
        separator = /(|USDT|TUSD|USDC|PAX|BTC|ETH|BCH|XQR|DOGE|LTC)\z/i =~ pair
        base      = pair[0..separator - 1]
        target    = pair[separator..-1]
        [base, target]
      rescue NoMethodError
        nil
      end
    end
  end
end
