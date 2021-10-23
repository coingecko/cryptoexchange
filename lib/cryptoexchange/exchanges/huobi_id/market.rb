module Cryptoexchange::Exchanges
  module HuobiId
    class Market < Cryptoexchange::Models::Market
      NAME = 'huobi_id'
      API_URL = 'https://www.huobi.com.co/api'

      def self.trade_page_url(args={})
        "https://www.huobi.com.co/exchange/#s=#{args[:base].downcase}_#{args[:target].downcase}"
      end

      def self.separate_symbol(pair)
        separator = /(USDT|BTC|ETH|IDR)\z/i =~ pair
        base      = pair[0..separator - 1]
        target    = pair[separator..-1]
        [base, target]
      rescue NoMethodError
        nil
      end      
    end
  end
end
